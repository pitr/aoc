require './vm'

def draw(map)
  x = Range.new(*map.keys.map(&:real).minmax)
  y = Range.new(*map.keys.map(&:imag).minmax)
  y.each{|y|x.each{|x|print map[Complex(x,y)]};puts}
end

DIRS = Hash[*%w[east south west north].each_with_index.map{|w,i|[w,1i**i]}.flatten].freeze
DIRBACK = Hash[*%w[east west north south].each_slice(2).map{|(a,b)|[a,b,b,a]}.flatten].freeze

def walk(vm, map, pos)
  out = vm.run_to_end.map(&:chr).join('')
  dirs = out.scan(/- (east|north|west|south)/).flatten.filter{|d|!map.has_key?(pos+DIRS[d])}
  puts out
  if pos == Complex(2,4)
    map[pos] = 'T'
    return
  else
    ix = out.index("Items here")
    if ix
      out.index(/- (.*)/,ix)
      item = $1
      case item
      when "giant electromagnet", "infinite loop", "photons", "escape pod", "molten lava"
      else
        puts "take #{item}"
        map[pos] = item[0]
        vm.run_to_consume("take #{item}".split('').map(&:ord))
        vm.run_to_consume([10])
      end
    end
  end

  dirs.each do |dir|
    map[pos+DIRS[dir]] = '.'
    puts dir
    puts ">>>>> #{pos+DIRS[dir]}"
    vm.run_to_consume(dir.split('').map(&:ord))
    vm.run_to_consume([10])
    walk(vm, map, pos+DIRS[dir])
    vm.run_to_consume(DIRBACK[dir].split('').map(&:ord))
    vm.run_to_consume([10])
  end
end

def day25_1(inp)
  vm = VM.new(inp)
  map = Hash.new('#')
  pos = Complex(0,0)
  map[pos] = '@'
  walk(vm, map, pos)
  draw(map)

  loop do
    print "> "
    input = gets
    break if input.chomp == 'hack'
    puts vm.run_to_end(input.split('').map(&:ord)).map(&:chr).join('')
  end

  puts "breaking!!!"

  # answer is hologram, cake, coin, hypercube

  inv = vm.run_to_end("inv\n".split('').map(&:ord)).map(&:chr).join('').lines.map{|l|l.chomp[2..] if l.start_with?("-")}.compact
  1.upto(inv.size).map{|x|inv.combination(x).to_a}.flatten(1).each do |comb|
    puts "trying #{comb.join(', ')}"
    drops = inv - comb
    drops.each do |drop|
      out = vm.run_to_end("drop #{drop}\n".split('').map(&:ord)).map(&:chr).join('')
      if !out.include?("You drop the #{drop}.")
        puts "Something wrong, tried to drop #{drop}, got:"
        puts out
        return
      end
    end
    result = vm.run_to_end("south\n".split('').map(&:ord)).map(&:chr).join('')
    if ! result.include?("you are ejected back to the checkpoint.")
      puts result
      break
    end
    puts "FAIL"
    drops.each do |drop|
      out = vm.run_to_end("take #{drop}\n".split('').map(&:ord)).map(&:chr).join('')
      if !out.include?("You take the #{drop}.")
        puts "Something wrong, tried to take #{drop}, got:"
        puts out
        return
      end
    end
  end

  loop do
    print "> "
    input = gets
    break if input.chomp == 'done'
    puts vm.run_to_end(input.split('').map(&:ord)).map(&:chr).join('')
  end
end

day25_1(File.read('25.txt'))
