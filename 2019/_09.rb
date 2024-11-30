require './vm'

def day9_1(inp, input)
  VM.new(inp).run_to_end(input)
end

day9_1("109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99",[]) # should print self
day9_1("1102,34915192,34915192,7,4,7,99,0",[]) # should be huge number
day9_1("104,1125899906842624,99",[]) # should be huge number

puts day9_1(File.read('in/09.txt'),[1])



def day9_2(inp, input)
  VM.new(inp).run_to_end(input)
end


puts day9_2(File.read('in/09.txt'), [2])
