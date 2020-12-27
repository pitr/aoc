require './vm'

def day21_1(inp)
  vm = VM.new(inp)
  # (!A | !C) & D
  res = <<END
OR A J
AND C J
NOT J J
AND D J
WALK
END
  puts vm.run_to_end(res.split('').map(&:ord)).last
end

# day21_1(File.read('21.txt'))

def day21_2(inp)
  vm = VM.new(inp)
  # (!A | !B | !C) & D & (E | H)
  res = <<END
OR A J
AND B J
AND C J
NOT J J
AND D J
OR E T
OR H T
AND T J
RUN
END
  puts vm.run_to_end(res.split('').map(&:ord)).last
end

day21_2(File.read('21.txt'))
