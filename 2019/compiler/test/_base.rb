require 'simplecov'            # These two lines must go first
SimpleCov.start do
  add_filter "/test/"
  add_filter "/answers/"
end

require "minitest/autorun"

require 'vm'
require 'compiler'

class Base < Minitest::Test
  def setup
    @compiler = Compiler.new
  end

  def execute(code, input=[])
    _, ic = @compiler.compile(code, "<buffer>")
    VM.new(ic).run_to_end(input)
  end

  def debug(code)
    ir, ic = @compiler.compile(code, "<buffer>")
    p ir
    p ic
    VM.new(ic).to_ruby
  end
end