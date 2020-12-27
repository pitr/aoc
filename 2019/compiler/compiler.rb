require_relative 'ir'
require_relative 'code_generator'

class Compiler
  def compile(code, file_name)
    ir = IR.new(code, file_name).to_ir
    ic = CodeGenerator.new(ir).generate
    return ir, ic
  end
end
