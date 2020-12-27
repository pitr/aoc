require './vm'

def day11_1(inp)
  m = VM.new(inp)
  map = Hash.new(0)
  painted = Set.new()
  pos = Complex(0,0)
  dir = Complex(0,-1)
  loop do
    case v=m.run([map[pos]])
    when :done then break
    when 0, 1 then painted << pos; map[pos] = v
    else raise "weird paint #{v}"
    end
    case v=m.run([])
    when 0 then dir /= Complex(0,1)
    when 1 then dir *= Complex(0,1)
    else raise "weird dir #{v}"
    end
    pos+=dir
  end
  painted.size
end

day11_1(File.read('11.txt'))


def day11_2(inp)
  offset = 50
  m = VM.new(inp)
  map = []
  pos = Complex(0,0)
  dir = Complex(0,-1)
  map[offset] = []
  map[offset][offset] = 1
  painted = Set.new()
  loop do
    case v=m.run([map[pos.imag+offset][pos.real+offset]])
    when :done then break
    when 0, 1 then map[pos.imag+offset][pos.real+offset] = v
    else raise "weird paint #{v}"
    end
    painted << pos
    case v=m.run([])
    when 0 then dir /= Complex(0,1)
    when 1 then dir *= Complex(0,1)
    else raise "weird dir #{v}"
    end
    pos+=dir
    (map[pos.imag+offset] ||= [])[pos.real+offset] ||= 0
  end
  map.each{|row|(row||[]).each{|c|print c==1 ? '#' : ' '};puts}
  painted.size
end

day11_2(File.read('11.txt'))
