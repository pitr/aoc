def simplify_at(steps, i, size)
  return unless (op2, arg2 = steps[i + 1])
  op1, arg1 = steps[i]

  # Adjacent pairs of the same operation can be combined.
  # (dealwith by multiplication, cut by addition, reverse by elimination)
  #
  # Adjacent pairs of different operation can be transposed,
  # if applying an appropriate transformation to the pair
  # (see each pair for details on its appropriate transformation).
  #
  # Sift all dealwith to the front of the list,
  # and all reverse to the back of the list.
  #
  # Applied enough times, the list should end with just one of each operation.
  case [op1, op2]
  when [:dealwith, :dealwith]
    steps[i, 2] = [
      [:dealwith, (arg1 * arg2) % size].freeze,
    ]
  when [:cut, :dealwith]
    steps[i, 2] = [
      [:dealwith, arg2].freeze,
      [:cut, (arg1 * arg2) % size].freeze,
    ]
  when [:cut, :cut]
    steps[i, 2] = [
      [:cut, (arg1 + arg2) % size].freeze,
    ]
  when [:reverse, :dealwith]
    steps[i, 2] = [
      [:dealwith, arg2].freeze,
      [:cut, -arg2 + 1].freeze,
      [:reverse].freeze,
    ]
  when [:reverse, :cut]
    steps[i, 2] = [
      [:cut, -arg2].freeze,
      [:reverse].freeze,
    ]
  when [:reverse, :reverse]
    steps[i, 2] = []
  end
end

def simplify(steps, size)
  until steps.map(&:first).uniq == steps.map(&:first)
    steps.each_index { |i| simplify_at(steps, i, size) }
  end
end

def modular_inverse(a, n)
  t, newt = [0, 1]
  r, newr = [n, a]
  until newr == 0
    q = r / newr
    t, newt = [newt, t - q * newt]
    r, newr = [newr, r - q * newr]
  end
  r > 1 ? nil : t % n
end

def parse(inp)
  inp.chomp.split("\n").map do |line|
    case line
    when 'deal into new stack'
      [:reverse].freeze
    when /cut (.*)/
      [:cut, $1.to_i].freeze
    when /deal with increment (.*)/
      [:dealwith, $1.to_i].freeze
    else raise "unknown command: #{line}"
    end
  end
end

def day22_1(inp, size, card)
  steps = parse(inp)
  simplify(steps, size)

  steps.each do |op, arg|
    case op
    when :dealwith
      card = (card*arg) % size
    when :reverse
      card = size-1 - card
    when :cut
      cut = arg
      cut = size + cut if cut < 0
      if cut <= card
        card = card-cut
      else
        card = size-cut+card
      end
    else raise "unknown #{op} #{arg}"
    end
  end
  card
end

def day22_2(inp, size, shuffles, pos)
  steps = parse(inp)
  simplify(steps, size)

  bits = {}
  power = 1
  while power <= shuffles
    bits[power] = steps.dup.freeze
    power <<= 1
    steps.concat(steps)
    simplify(steps, size)
  end

  relevant_bits = bits.keys.select { |k| shuffles & k != 0 }
  raise "WRONG BITS!!! #{relevant_bits.sum} vs #{shuffles}" if relevant_bits.sum != shuffles
  final = relevant_bits.flat_map(&bits)
  simplify(final, size)
  final.reverse_each do |op, arg|
    case op
    when :dealwith
      pos = (pos * modular_inverse(arg, size)) % size
    when :reverse
      pos = size-1 - pos
    when :cut
      pos = (pos + arg) % size
    else raise "Unknown #{op} #{arg}"
    end
  end
  pos
end

puts "should be 1", day22_1(<<END, 10, 3)
deal with increment 7
deal into new stack
deal into new stack
END

puts "should be 0", day22_1(<<END, 10, 3)
cut 6
deal with increment 7
deal into new stack
END

puts "should be 1", day22_1(<<END, 10, 3)
deal with increment 7
deal with increment 9
cut -2
END

puts "should be 8", day22_1(<<END, 10, 3)
deal into new stack
cut -2
deal with increment 7
cut 8
cut -4
deal with increment 7
cut 3
deal with increment 9
deal with increment 3
cut -1
END

puts day22_1(File.read('in/22.txt'), 10007, 2019)

puts day22_2(File.read('in/22.txt'), 119315717514047, 101741582076661, 2020)
