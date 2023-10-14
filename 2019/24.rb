require 'set'

DIR = [1,-1,1i,-1i].freeze
E = '.'.ord
F = '#'.ord

def draw(map)
  5.times do |y|
    5.times do |x|
      if x==y && x==2
        print '?'
      else
        print map[Complex(x,y)].chr
      end
    end
    puts
  end
end

def day24_1(inp)
  past = Set.new
  cur = Hash.new(E)
  inp.chomp.split("\n").each_with_index do |line,y|
    line.split('').each_with_index do |c,x|
      cur[Complex(x,y)] = F if c == '#'
    end
  end
  loop do
    sig = cur.hash
    break if past.include?(sig)
    past << sig

    nxt = Hash.new(E)
    5.times { |y| 5.times { |x|
      pos=Complex(x,y)
      if E==cur[pos] && [1,2].include?(DIR.map { |dir| cur[pos+dir] == F ? 1 : 0 }.sum)
        nxt[pos] = F
      elsif F==cur[pos] && [1].include?(DIR.map { |dir| cur[pos+dir] == F ? 1 : 0 }.sum)
        nxt[pos] = F
      end
    }}
    cur = nxt
  end
  p cur.keys.map { |pos| 2**(pos.real+5*pos.imag) }.sum
end

def day24_2(inp, minutes)
  cur = Hash.new { Hash.new(E) }
  inp.chomp.split("\n").each_with_index do |line,y|
    line.split('').each_with_index do |c,x|
      if c == '#'
        cur[0] = cur[0]
        cur[0][Complex(x,y)] = F
      end
    end
  end
  minutes.times do
    nxt = Hash.new { Hash.new(E) }
    min,max = cur.keys.minmax
    (min-1).upto(max+1).each do |level|
      5.times { |y| 5.times { |x|
        pos=Complex(x,y)
        next if pos == Complex(2,2)
        block = nxt[level]
        neighbors = DIR.map do |dir|
          dst = pos+dir
          if dst.real == -1
            cur[level-1][Complex(1,2)] == F ? 1 : 0
          elsif dst.real == 5
            cur[level-1][Complex(3,2)] == F ? 1 : 0
          elsif dst.imag == -1
            cur[level-1][Complex(2,1)] == F ? 1 : 0
          elsif dst.imag == 5
            cur[level-1][Complex(2,3)] == F ? 1 : 0
          elsif dst == Complex(2,2)
            5.times.map do |z|
              if pos.real == 1
                cur[level+1][Complex(0,z)] == F ? 1 : 0
              elsif pos.real == 3
                cur[level+1][Complex(4,z)] == F ? 1 : 0
              elsif pos.imag == 1
                cur[level+1][Complex(z,0)] == F ? 1 : 0
              elsif pos.imag == 3
                cur[level+1][Complex(z,4)] == F ? 1 : 0
              else raise "looking at middle from weird position #{pos}"
              end
            end.sum
          else
            cur[level][dst] == F ? 1 : 0
          end
        end.sum
        case cur[level][pos]
        when E then block[pos] = F if [1,2].include?(neighbors)
        when F then block[pos] = F if 1 == neighbors
        else raise "unknown symbol #{cur[level][pos]}"
        end
        nxt[level] = block if block.size > 0
      }}
    end
    cur = nxt
  end
  # min,max = cur.keys.minmax
  # min.upto(max).each do |level|
  #   puts "Depth #{level}:";draw(cur[level]);puts
  # end
  p cur.map { |_,b| b.map { |_,c| c == F ? 1 : 0 }.sum }.sum
end

# day24_1(<<END) # should be 2129920
# ....#
# #..#.
# #..##
# ..#..
# #....
# END

# day24_1(File.read('in/24.txt'))


day24_2(<<END, 10)
....#
#..#.
#..##
..#..
#....
END

day24_2(File.read('in/24.txt'), 200)
