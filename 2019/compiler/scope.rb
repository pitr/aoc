class Scope
  class Type
    attr_reader :is_const
    def initialize(is_const: false)
      @is_const = is_const
    end
    def type_name
      self.class.name.downcase
    end
  end

  class Int < Type; end
  class Str < Type; end

  class Arr < Type
    attr_reader :size
    def initialize(size)
      super(is_const: true)
      @size = size
    end
  end

  class Func < Type
    attr_reader :arity
    def initialize(arity)
      super(is_const: true)
      @arity = arity
    end
  end

  def initialize(parent)
    @parent = parent
    @vars = {}
  end
  def get(name)
    type   = @vars[name]
    type ||= @parent.get(name) if @parent
    type
  end
  def set(name, type)
    not_supported("non-type variable #{name} (#{type.type_name})") unless type.is_a? Type
    if old = @vars[name]
      if type.class != old.class
        not_supported("changing type of variable #{name} (was #{old.type_name}, becomes #{type.type_name})")
      elsif old.is_const
        not_supported("re-declaring constant #{name} (#{old.type_name})")
      end
    end
    @vars[name] = type
    type
  end
  def self.root
    scope = self.new(nil)
    scope.set(:print, Func.new(1))
    scope.set(:read, Func.new(0))
    # FIXME add division
    scope.set(:_div, Func.new(2))
    scope
  end
  def child
    self.class.new(self)
  end

  def not_supported(message)
    raise "#{message} is not supported!"
  end
end
