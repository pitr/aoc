class Env
  attr_reader :data

  def initialize(funcs = {}, global = true)
    @global = global
    @stack = 0
    @labels = {}
    @funcs = funcs
    @data = []
    @consts = {}
  end
  def new
    Env.new(@funcs, false)
  end
  def global?
    @global
  end
  def has?(name)
    @labels.has_key? name
  end
  def size # returns next free value on stack
    @stack
  end
  def get(name=nil)
    if name.nil?
      addr = @stack
      @stack+=1
      addr
    else
      raise "unknown variable #{name}" unless @labels.has_key?(name)
      @labels[name]
    end
  end
  def malloc(name)
    addr = @stack
    @stack += 1
    @labels[name] = addr
    addr
  end
  def setdata(name, values)
    raise "not supported outside global scope" unless global?
    addr = @data.size
    @data += values
    @labels[name] = addr
  end
  def setconst(name, expr)
    raise "overriding const variable #{name}" if @consts.has_key?(name)
    @consts[name] = expr
  end
  def getconst(name)
    raise "overriding const variable #{name}" unless @consts.has_key?(name)
    @consts[name]
  end
  def func(name, addr=nil)
    if addr
      raise "redefining function #{name}" if @funcs.has_key?(name)
      @funcs[name] = addr
    else
      @funcs[name] or raise "undefined function #{name}"
    end
  end
end
