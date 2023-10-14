class VM
  attr_accessor :mem, :pc, :rb, :done
  def initialize(inp)
    @mem = inp.strip.split(',').map(&:to_i)
    @pc = 0
    @rb = 0
    @done = false
  end
  def set(i, v)
    @mem[i] = v
  end
  def [](n)
    base = @mem[@pc].to_s[-2-n].to_i
    arg = @mem[@pc+n]
    case base
    when 0 then @mem[arg].to_i
    when 1 then arg
    when 2 then @mem[@rb + arg].to_i
    else raise "weird base #{base}"
    end
  end
  def []=(n, v)
    base = @mem[@pc].to_s[-2-n].to_i
    arg = @mem[@pc+n]
    case base
    when 0 then @mem[arg] = v
    when 1 then raise "setting to arg in immediate mode"
    when 2 then @mem[@rb + arg] = v
    else raise "weird base #{base}"
    end
  end
  def run_to_end(input=[])
    output = []
    loop do
      val = step(input)
      case val
      when :done then return output
      when :paused then return output
      when nil then next
      else output << val
      end
    end
  end
  def run(input=[])
    loop do
      val = step(input)
      return val unless val.nil?
    end
  end
  def run_to_consume(input=[])
    output = []
    until input.empty?
      val = step(input)
      case val
      when :done, :paused then raise "finished before input was consumed"
      when nil then next
      else output << val
      end
    end
  end
  def step(input)
    op = @mem[@pc]
    raise "no commands at #{@pc}" if op.nil?
    case op%100
    when 1 then self[3] = self[1]+self[2]; @pc+=4
    when 2 then self[3] = self[1]*self[2]; @pc+=4
    when 3 then return :paused if input.empty?; self[1]=input.shift; @pc+=2
    when 4 then r = self[1]; @pc+=2; return r
    when 5 then @pc = self[1]!=0 ? self[2] : @pc+3
    when 6 then @pc = self[1]==0 ? self[2] : @pc+3
    when 7 then self[3] = self[1] <  self[2] ? 1 : 0; @pc+=4
    when 8 then self[3] = self[1] == self[2] ? 1 : 0; @pc+=4
    when 9 then @rb += self[1]; @pc+=2
    when 99 then @done = true; return :done
    else raise "unknown op #{op}"
    end
    nil
  end

  # decompiler

  def arg_name(n)
    base = @mem[@dpc].to_s[-2-n].to_i
    arg = @mem[@dpc+n]
    case base
    when 0 then "$#{arg}"
    when 1 then "#{arg}"
    when 2 then "$$#{arg}"
    else raise "weird base #{base}"
    end
  end
  def to_ruby
    @dpc = 0
    loop do
      return if @mem[@dpc].nil?
      op = @mem[@dpc]
      print @dpc.to_s.rjust(4, ' ') + ": "
      case op%100
      when 1
        a = arg_name(1)
        b = arg_name(2)
        if a == '0'
          puts "#{arg_name(3)} = #{b}"
        elsif b == '0'
          puts "#{arg_name(3)} = #{a}"
        elsif a[0] == '-'
          puts "#{arg_name(3)} = #{b} - #{a[1..]}"
        elsif b[0] == '-'
          puts "#{arg_name(3)} = #{a} - #{b[1..]}"
        else
          puts "#{arg_name(3)} = #{a} + #{b}"
        end
        @dpc+=4
      when 2
        a = arg_name(1)
        b = arg_name(2)
        if a == '1'
          puts "#{arg_name(3)} = #{b}"
        elsif b == '1'
          puts "#{arg_name(3)} = #{a}"
        elsif a == '-1'
          puts "#{arg_name(3)} = -(#{b})"
        elsif b == '-1'
          puts "#{arg_name(3)} = -(#{a})"
        elsif a == '0' || b == '0'
          puts "#{arg_name(3)} = 0"
        else
          puts "#{arg_name(3)} = #{a} * #{b}"
        end
        @dpc+=4
      when 3 then puts "read #{arg_name(1)}"; @dpc+=2
      when 4 then puts "print #{arg_name(1)}"; @dpc+=2
      when 5
        a = arg_name(1)
        if a.to_i > 0
          puts "goto #{arg_name(2)}"
        else
          puts "goto #{arg_name(2)} if #{a} != 0"
        end
        @dpc+=3
      when 6
        a = arg_name(1)
        if a == '0'
          puts "goto #{arg_name(2)}"
        else
          puts "goto #{arg_name(2)} if #{a} == 0"
        end
        @dpc+=3
      when 7
        a = arg_name(1)
        b = arg_name(2)
        if a == b
          puts "#{arg_name(3)} = 0"
        else
          puts "#{arg_name(3)} = #{a} < #{b} ? 1 : 0"
        end
        @dpc+=4
      when 8
        a = arg_name(1)
        b = arg_name(2)
        if a == b
          puts "#{arg_name(3)} = 1"
        else
          puts "#{arg_name(3)} = #{a} == #{b} ? 1 : 0"
        end
        @dpc+=4
      when 9 then puts "$$ += #{arg_name(1)}"; @dpc+=2
      when 99 then puts "exit"; @dpc+=1
      else
        puts op.to_s
        @dpc+=1
      end
    rescue
      puts op.to_s
      @dpc+=1
    end
  end
end
