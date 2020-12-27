

Var = Struct.new(:name) do
  def to_s; "#{name}"; end
end
Int = Struct.new(:val) do
  def to_s; "#{val}"; end
end
Str = Struct.new(:str) do
  def to_s; "\"#{str}\""; end
end
Bool = Struct.new(:val) do
  def to_s; "#{val}"; end
end
ArrayInit = Struct.new(:size, :elements) do
  def to_s; "Array.new(#{size})"; end
end
ArrayGet = Struct.new(:name, :ix) do
  def to_s; "#{name}[#{ix}]"; end
end
ArraySet = Struct.new(:name, :ix, :expr) do
  def to_s; "#{name}[#{ix}] = #{expr}"; end
end
Return = Struct.new(:expr) do
  def to_s; "return #{expr}"; end
end
Break = Struct.new(:_) do
  def to_s; "break"; end
end
Next = Struct.new(:_) do
  def to_s; "next"; end
end
Funcall = Struct.new(:name, :args) do
  def to_s; "#{name}("+args.map {|s|s.to_s}.join(",")+")"; end
end
Func = Struct.new(:name, :args, :body) do
  def arity; args.length; end
  # :nocov:
  def to_s
    "def #{name}(#{arity})\n" + body.to_s.lines.map{|l|'  '+l}.join + "\nend"
  end
  # :nocov:
end
If = Struct.new(:expr, :body, :else) do
  # :nocov:
  def to_s
    if self.else
      "if #{expr}\n" + body.to_s.lines.map{|l|'  '+l}.join +
      "\nelse\n" + self.else.to_s.lines.map{|l|'  '+l}.join +
      "\nend"
    else
      "if #{expr}\n" + body.to_s.lines.map{|l|'  '+l}.join + "\nend"
    end
  end
  # :nocov:
end
While = Struct.new(:expr, :body) do
  def to_s; "while #{expr}\n" + body.to_s.lines.map{|l|'  '+l}.join + "\nend"; end
end
Assign = Struct.new(:name, :expr) do
  def to_s; "#{name} = #{expr}"; end
end
Intop = Struct.new(:op, :lhs, :rhs) do
  def to_s; "#{lhs} #{op} #{rhs}"; end
end
Boolop = Struct.new(:op, :lhs, :rhs) do
  def to_s; "#{lhs} #{op} #{rhs}"; end
end
Block = Struct.new(:stmts) do
  # :nocov:
  def to_s
    "begin\n" +
    stmts.map(&:to_s).join("\n").lines.map{|l|'  '+l}.join +
    "\nend"
  end
  # :nocov:
end
