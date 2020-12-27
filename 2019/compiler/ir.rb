require 'parser/ruby27'
require_relative 'scope'
require_relative 'nodes'

class IR
  def initialize(code, file_name)
    buffer = Parser::Source::Buffer.new(file_name)
    buffer.source = code

    parser = Parser::Ruby27.new
    parser.diagnostics.consumer = lambda { |diag| puts diag.render }

    @ast = parser.parse(buffer)
    raise 'unable to parse' unless @ast
  end

  def to_ir
    generate_ir(Scope.root, @ast)
  end

private
  def generate_ir(scope, node)
    case node.type
    when :begin
      Block.new(node.children.map { |node| generate_ir(scope, node) })
    when :def
      not_supported(node, "complicated def") if node.children.size != 3
      name = node.children[0]
      not_supported(node, "complicated function name") unless name.is_a? Symbol
      funscope = Scope.root
      args = generate_ir(funscope, node.children[1])
      type = Scope::Func.new(args.size)
      funscope.set(name, type) # so this function can call itself
      body = generate_ir(funscope, node.children[2])
      scope.set(name, type)
      Func.new(name, args, body)
    when :args
      node.children.map { |node| generate_ir(scope, node) }
    when :arg
      name = node.children.first
      scope.set(name, Scope::Int.new(is_const: false))
      Var.new(name)
    when :if
      not_supported(node, "complicated if") unless [3].include? node.children.size
      cond = generate_ir(scope, node.children[0])
      not_supported(node, "non-bool if") unless [Boolop, Bool].include? cond.class
      body = generate_ir(scope.child, node.children[1])
      els = generate_ir(scope.child, node.children[2]) if node.children[2] != nil
      If.new(cond, body, els)
    when :case
      not_supported(node, "no value on case") if node.children[0].nil?
      expr = generate_ir(scope, node.children[0])
      node.children[1..].reverse.inject(nil) do |els, branch|
        if branch.nil?
          nil
        elsif branch.type == :when
          not_supported(node, "complicated when") if branch.children.size != 2
          cond = Boolop.new(:==, expr, generate_ir(scope, branch.children[0]))
          If.new(cond, generate_ir(scope.child, branch.children[1]), els)
        else
          generate_ir(scope.child, branch)
        end
      end
    when :while
      not_supported(node, "complicated while") if node.children.size != 2
      cond = generate_ir(scope, node.children[0])
      not_supported(node, "non-bool while") unless [Boolop, Bool].include? cond.class
      body = generate_ir(scope.child, node.children[1])
      While.new(cond, body)
    when :lvasgn
      not_supported(node, "complicated assignment") unless [1, 2].include? node.children.size
      name = node.children[0]
      not_supported(node, "complicated variable") unless name.is_a? Symbol
      if node.children.size == 1
        not_supported(node, "undefined variable #{name}") unless scope.get(name).is_a? Scope::Int
        Var.new(name)
      else
        val = generate_ir(scope, node.children[1])
        not_supported(node, "non-int assign (was #{val.class})") unless [Int, Intop, Var, Funcall, ArrayInit, Str].include? val.class
        case val
        when ArrayInit
          scope.set(name, Scope::Arr.new(val.size))
        when Str
          scope.set(name, Scope::Str.new)
        else
          scope.set(name, Scope::Int.new(is_const: false))
        end
        Assign.new(name, val)
      end
    when :op_asgn
      not_supported(node, "complicated assignment") if node.children.size != 3
      var = generate_ir(scope, node.children[0])
      not_supported(node, "complicated assignment (was #{var.class})") unless [Var, ArrayGet].include? var.class
      verb = node.children[1]
      not_supported(node, "#{verb} in assignment") unless %i[* - +].include?(verb)
      val = generate_ir(scope, node.children[2])
      not_supported(node, "non-int assign (was #{val.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? val.class
      if var.is_a?(ArrayGet)
        ArraySet.new(var.name, var.ix, Intop.new(verb, var, val))
      elsif val.is_a?(Int) && verb == :-
        val.val = -val.val
        Assign.new(var.name, Intop.new(:+, var, val))
      else
        Assign.new(var.name, Intop.new(verb, var, val))
      end
    when :lvar
      not_supported(node, "complicated variable") if node.children.size != 1
      name = node.children[0]
      not_supported(node, "complicated variable") unless name.is_a? Symbol
      not_supported(node, "undefined variable #{name}") unless scope.get(name).is_a? Scope::Type
      Var.new(name)
    when :return
      not_supported(node, "complicated return") if node.children.size != 1
      expr = generate_ir(scope, node.children[0])
      not_supported(node, "non-int assign (was #{expr.class})") unless [Int, Intop, Var, Funcall].include? expr.class
      Return.new(expr)
    when :break
      not_supported(node, "complicated break") if node.children.size != 0
      Break.new
    when :next
      not_supported(node, "complicated next") if node.children.size != 0
      Next.new
    when :send
      obj = node.children[0]
      verb = node.children[1]
      if obj.nil?
        not_supported(node, "complicated call") unless verb.is_a? Symbol
        if verb.to_s.match?(/-(.*)/)
          name = $1
          not_supported(node, "undefined variable #{name}") unless scope.get(name).is_a? Scope::Var
          return Intop.new(:-, Int.new(0), Var.new(name))
        end
        not_supported(node, "undefined function #{verb} #{verb.to_s.match /−(.*)/}") unless scope.get(verb).is_a? Scope::Func
        args = node.children[2..].map do |node|
          arg = generate_ir(scope, node)
          not_supported(node, "non-int argument (was #{arg.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? arg.class
          arg
        end
        func = scope.get(verb)
        not_supported(node, "unmatched function arity for #{verb} (expecting #{func.arity})") if func.arity != args.size
        return Funcall.new(verb, args)
      end
      not_supported(node, "complicated expr") unless [2,3,4].include? node.children.size
      case verb
      when :+, :-, :*
        not_supported(node, "number of args for operator #{verb}") if node.children.size != 3
        lhs = generate_ir(scope, obj)
        rhs = generate_ir(scope, node.children[2])
        not_supported(node, "non-int lhs (was #{lhs.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? lhs.class
        not_supported(node, "non-int rhs (was #{rhs.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? rhs.class
        if lhs.is_a?(Int) && rhs.is_a?(Int)
          Int.new(lhs.val.send(verb, rhs.val))
        elsif rhs.is_a?(Int) && verb == :-
          rhs.val = -rhs.val
          Intop.new(:+, lhs, rhs)
        else
          Intop.new(verb, lhs, rhs)
        end
      when :>, :<, :==
        not_supported(node, "number of args for operator #{verb}") if node.children.size != 3
        lhs = generate_ir(scope, obj)
        rhs = generate_ir(scope, node.children[2])
        not_supported(node, "non-int lhs (was #{lhs.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? lhs.class
        not_supported(node, "non-int rhs (was #{rhs.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? rhs.class
        if verb == :>
          Boolop.new(:<, rhs, lhs)
        else
          Boolop.new(verb, lhs, rhs)
        end
      when :new
        not_supported(node, "number of args for operator #{verb}") unless [3, 4].include? node.children.size
        not_supported(node, "calling new on non-Array") if node.children[0].type != :const || node.children[0].children[0] != nil || node.children[0].children[1] != :Array
        rhs = generate_ir(scope, node.children[2])
        default = nil
        if node.children.size == 4
          val = generate_ir(scope, node.children[3])
          not_supported(node, "non-int default value (was #{val.class})") unless val.is_a? Int
          default = val.val
        end
        not_supported(node, "non-int rhs (was #{rhs.class})") unless rhs.is_a? Int
        ArrayInit.new(rhs.val, [default]*rhs.val)
      when :[]
        not_supported(node, "number of args for operator #{verb}") if node.children.size != 3
        var = generate_ir(scope, obj)
        ix = generate_ir(scope, node.children[2])
        not_supported(node, "non-var obj (was #{var.class})") unless var.is_a? Var
        not_supported(node, "undefined array #{var.name}") if scope.get(var.name).nil?
        not_supported(node, "non-array var #{var.name} (was #{scope.get(var.name).type_name})") unless scope.get(var.name).is_a? Scope::Arr
        not_supported(node, "non-int index (was #{ix.class})") unless ix.is_a? Int
        not_supported(node, "out of bound index (was #{ix.val})") if ix.val < 0 || ix.val >= scope.get(var.name).size
        ArrayGet.new(var.name, ix.val)
      when :[]=
        not_supported(node, "number of args for operator #{verb}") if node.children.size != 4
        var = generate_ir(scope, obj)
        ix = generate_ir(scope, node.children[2])
        rhs = generate_ir(scope, node.children[3])
        not_supported(node, "non-var pobj (was #{var.class})") unless var.is_a? Var
        not_supported(node, "undefined array #{var.name}") if scope.get(var.name).nil?
        not_supported(node, "non-array var #{var.name} (was #{scope.get(var.name).type_name})") unless scope.get(var.name).is_a? Scope::Arr
        not_supported(node, "non-int index (was #{ix.class})") unless ix.is_a? Int
        not_supported(node, "out of bound index (was #{ix.val})") if ix.val < 0 || ix.val >= scope.get(var.name).size
        not_supported(node, "non-int rhs (was #{rhs.class})") unless [Int, Intop, Var, Funcall].include? rhs.class
        ArraySet.new(var.name, ix.val, rhs)
      when :-@
        not_supported(node, "number of args for operator #{verb}") if node.children.size != 2
        rhs = generate_ir(scope, obj)
        not_supported(node, "non-int expr (was #{rhs.class})") unless [Int, Intop, Var, Funcall, ArrayGet].include? rhs.class
        if rhs.is_a?(Int)
          rhs.val = -rhs.val
          rhs
        else
          Intop.new(:-, Int.new(0), rhs)
        end
      else
        not_supported(node, "operator #{verb}")
      end
    when :int
      not_supported(node, "complicated number") if node.children.size != 1
      Int.new(node.children[0])
    when :str
      not_supported(node, "complicated string") if node.children.size != 1 || !node.children[0].is_a?(String)
      if node.children[0].size == 1
        Int.new(node.children[0].ord)
      else
        Str.new(node.children[0])
      end
    when :true
      not_supported(node, "complicated true") if node.children.size != 0
      Bool.new(true)
    when :false
      not_supported(node, "complicated false") if node.children.size != 0
      Bool.new(false)
    when :array
      elements = node.children.map do |child|
        el = generate_ir(scope, child)
        not_supported(node, "non-int element in array") unless el.is_a? Int
        el.val
      end
      ArrayInit.new(elements.size, elements)
    else
      not_supported(node, node.type)
    end
  end

  def not_supported(node, message)
    print "#{message}"
    if node
      loc = node.location.expression
      print " at #{loc.source_buffer.name}:#{loc.line}"
    end
    puts " is not supported!"

    p node

    raise "cannot compile"
  end
end
