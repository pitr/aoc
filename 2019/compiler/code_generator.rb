require_relative 'env'
require_relative 'nodes'

class CodeGenerator
  def initialize(ast)
    @ast = ast
  end
  def generate
    env = Env.new
    ic  = op(LINCR, argNumber(:prog_to_end))
    ic += to_ic(@ast, env, ic.size)
    ic += op(EXIT)
    prog_to_data = ic.size
    ic += env.data
    prog_to_end = ic.size

    ic.pop while ic.last.nil? # remove un-initialized values in data at the end
    ic.each_with_index do |c, ix|
      case c
      when /prog_to_data\((.*)\)/ then ic[ix] = prog_to_data + $1.to_i
      when :prog_to_end then ic[ix] = prog_to_end
      when nil then ic[ix] = 0
      end
    end
    ic.join(',')
  end

private

  ADD   = 1 # self[3] = self[1]+self[2]; @pc+=4
  MUL   = 2 # self[3] = self[1]*self[2]; @pc+=4
  READ  = 3 # return :paused if input.empty?; self[1]=input.shift; @pc+=2
  PUT   = 4 # r = self[1]; @pc+=2; return r
  JN    = 5 # @pc = self[1]!=0 ? self[2] : @pc+3
  JZ    = 6 # @pc = self[1]==0 ? self[2] : @pc+3
  LT    = 7 # self[3] = self[1] <  self[2] ? 1 : 0; @pc+=4
  EQ    = 8 # self[3] = self[1] == self[2] ? 1 : 0; @pc+=4
  LINCR = 9 # @rb += self[1]; @pc+=2
  EXIT  = 99 # @done = true; return :done

  Argument = Struct.new(:val, :mod)
  def argGlobal(val); Argument.new(val, 0); end
  def argNumber(val); Argument.new(val, 1); end
  def argLocal(val); Argument.new(val, 2); end

  def op(id, *args)
    args.each_with_index do |arg, ix|
      id += 10 * arg.mod * 10**(ix+1)
    end
    [id] + args.map(&:val)
  end

  def to_ic(node, env, offset, dst: nil)
    case node
    when Block
      node.stmts.inject([]) do |ic, stmt|
        ic + to_ic(stmt, env, offset + ic.size)
      end
    when Return
      raise "cannot return from global scope" if env.global?
      # eval expression and move as return value to $$1
      ic = case node.expr
      when Int
        op(ADD, argNumber(node.expr.val), argNumber(0), argLocal(1))
      when Var
        op(ADD, argLocal(env.get(node.expr.name)), argNumber(0), argLocal(1))
      when Funcall
        to_ic(node.expr, env, offset, dst: 1)
      else
        i = env.get
        to_ic(node.expr, env, offset, dst: i) +
        op(ADD, argLocal(i), argNumber(0), argLocal(1))

      # jump to $$0, which is assumed to be return location
      end + op(JZ, argNumber(0), argLocal(0))
    when Break
      op(JZ, argNumber(0), argNumber(:while_to_end))
    when Next
      op(JZ, argNumber(0), argNumber(:while_to_begin))
    when Funcall
      case node.name
      when :print
        raise "print does not return any value" if dst != nil
        arg = node.args[0]
        case arg
        when Int
          op(PUT, argNumber(arg.val))
        when Var
          if env.has?(arg.name)
            op(PUT, argLocal(env.get(arg.name)))
          else
            s = env.getconst(arg.name)
            case s
            when Str
              s.str.split('').each { |char| op(PUT, argNumber(char.ord)) }
            else raise "unknown constant #{arg.name}"
            end
          end
        else
          i = env.get
          ic  = to_ic(arg, env, offset, dst: i)
          ic += op(PUT, argLocal(i))
        end
      when :read
        raise "read returns 1 value" if dst.nil?
        op(READ, argLocal(dst))
      else
        func_location = env.func(node.name)
        raise "#{node.name} returns 1 value" if dst.nil?
        ic = []
        # calulate arguments
        is = node.args.each_with_index.map do |arg, ix|
          case arg
          when Int
            op(ADD, argNumber(arg.val), argNumber(0), argLocal(ix))
          when Var
            op(ADD, argLocal(env.get(arg.name)), argNumber(0), argLocal(ix))
          else
            i = env.get
            ic += to_ic(arg, env, offset+ic.size, dst: i)
            op(ADD, argLocal(i), argNumber(0), argLocal(ix))
          end
        end
        # put values on stack as such [return location, arg1, arg2, arg3]
        # do not actually allocate space for it, assume function will know how to find it
        i = env.size
        ic += op(ADD, argNumber(:funcall_to_end), argNumber(0), argLocal(i))
        # put arguments, leaving room for return location
        ic += is.map { |instruction| instruction[3]+=i+1; instruction }.flatten
        # move relative base by stack size to allocate new stack, and jump to function
        ic += op(LINCR, argNumber(i))
        ic += op(JZ, argNumber(0), argNumber(func_location))
        ic  = ic.map { |op| op == :funcall_to_end ? offset+ic.size : op }
        # on return, restore stack and move result to destination
        ic += op(LINCR, argNumber(-i))
        ic += op(ADD, argLocal(i+1), argNumber(0), argLocal(dst))
        ic
      end
    when Func
      ic  = op(JZ, argNumber(0), argNumber(:func_to_end))

      env.func(node.name, offset+ic.size)
      funenv = env.new
      ret = funenv.get
      raise "unexpected, first var in function scope should be $$0, got $$#{ret}" if ret != 0
      node.args.each { |arg| funenv.malloc(arg.name) }

      ic += to_ic(node.body, funenv, offset+ic.size)
      # should not actually reach the end, should have returned in body
      ic += [0]
      ic.map { |op| op == :func_to_end ? offset+ic.size : op }
    when If
      raise "if does not return values" if dst
      if node.expr.is_a? Bool
        if node.expr.val
          pre = []
          node.else = nil
        else
          pre = []
          node.body = nil
        end
      else
        tmp = env.get
        pre  = to_ic(node.expr, env, offset, dst: tmp)
        pre += op(JZ, argLocal(tmp), argNumber(:if_to_else))
      end
      ic  = []
      ic += to_ic(node.body, env, offset+pre.size) if node.body
      if node.else
        ic += op(JZ, argNumber(0), argNumber(:if_to_end)) unless ic.empty?
        post = to_ic(node.else, env, offset+pre.size+ic.size)
        pre + ic + post
      else
        pre + ic
      end.map do |op|
        case op
        when :if_to_else
          offset + pre.size + ic.size
        when :if_to_end
          offset + pre.size + ic.size + post.size
        else op
        end
      end
    when While
      raise "while does not return values" if dst
      if node.expr.is_a? Bool
        if node.expr.val
          pre = []
        else
          return [] # while false never runs
        end
      else
        tmp = env.get
        pre  = to_ic(node.expr, env, offset, dst: tmp)
        pre += op(JZ, argLocal(tmp), argNumber(:while_to_end))
      end
      ic  = to_ic(node.body, env, offset+pre.size)
      ic += op(JZ, argNumber(0), argNumber(offset))
      (pre + ic).map do |op|
        case op
        when :while_to_end
          offset + pre.size + ic.size
        when :while_to_begin
          offset
        else
          op
        end
      end
    when Assign
      raise "assignment does not return values" if dst
      case node.expr
      when Funcall
        tmp = env.has?(node.name) ? env.get(node.name) : env.malloc(node.name)
        to_ic(node.expr, env, offset, dst: tmp)
      when Int
        tmp = env.has?(node.name) ? env.get(node.name) : env.malloc(node.name)
        op(ADD, argNumber(node.expr.val), argNumber(0), argLocal(tmp))
      when Var
        tmp = env.has?(node.name) ? env.get(node.name) : env.malloc(node.name)
        src = env.get(node.expr.name)
        op(ADD, argLocal(src), argNumber(0), argLocal(tmp))
      when Intop
        tmp = env.has?(node.name) ? env.get(node.name) : env.malloc(node.name)
        to_ic(node.expr, env, offset, dst: tmp)
      when ArrayInit
        raise "cannot create arrays outside global scope" unless env.global?
        env.setdata(node.name, node.expr.elements)
        []
      when Str
        env.setconst(node.name, node.expr)
        []
      # :nocov:
      else raise "unsupported assign value #{node.expr.class}:\n#{node.inspect}"
      # :nocov:
      end
    when Intop
      raise "#{node} yields a value that must be consumed" if dst.nil?
      ic  = []
      arg1, arg2 = [node.lhs, node.rhs].map do |node|
        case node
        when Int
          argNumber(node.val)
        when Var
          argLocal(env.get(node.name))
        else
          tmp = env.get
          ic += to_ic(node, env, offset+ic.size, dst: tmp)
          argLocal(tmp)
        end
      end
      ic += case node.op
      when :+
        op(ADD, arg1, arg2, argLocal(dst))
      when :-
        tmp = env.get
        op(MUL, arg2, argNumber(-1), argLocal(tmp)) +
        op(ADD, arg1, argLocal(tmp), argLocal(dst))
      when :*
        op(MUL, arg1, arg2, argLocal(dst))
      end
    when Boolop
      raise "#{node} yields a value that must be consumed" if dst.nil?
      ic  = []
      arg1, arg2 = [node.lhs, node.rhs].map do |node|
        case node
        when Int
          argNumber(node.val)
        when Var
          argLocal(env.get(node.name))
        else
          tmp = env.get
          ic += to_ic(node, env, offset+ic.size, dst: tmp)
          argLocal(tmp)
        end
      end
      ic += case node.op
      when :<
        op(LT, arg1, arg2, argLocal(dst))
      when :==
        op(EQ, arg1, arg2, argLocal(dst))
      end
    when ArrayGet
      raise "#{node} yields a value that must be consumed" if dst.nil?
      addr = env.get(node.name)
      op(ADD, argGlobal("prog_to_data(#{addr + node.ix})"), argNumber(0), argLocal(dst))
    when ArraySet
      raise "array assignment does not return values" if dst
      ic = []
      src = case node.expr
      when Int
        argNumber(node.expr.val)
      when Var
        argLocal(env.get(node.expr.name))
      else
        tmp = env.get
        ic += to_ic(node.expr, env, offset, dst: tmp)
        argLocal(tmp)
      end
      addr = env.get(node.name)
      ic + op(ADD, src, argNumber(0), argGlobal("prog_to_data(#{addr + node.ix})"))
    # :nocov:
    else raise "Unknown AST node #{node.class}"
    # :nocov:
    end
  end
end