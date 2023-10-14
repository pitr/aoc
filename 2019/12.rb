M = Struct.new(:x, :dx) do
  def inspect
    "pos=<x=#{x[0]}, y=#{x[1]}, z=#{x[2]}>, vel=<x=#{dx[0]}, y=#{dx[1]}, z=#{dx[2]}>"
  end
end

def day12_1(inp, steps)
  m = inp.lines.map { |l| M.new(l.scan(/-?\d+/).map(&:to_i), [0]*3) }
  steps.times do |n|
    3.times do |i|
      m.combination(2).each do |(a,b)|
        if a.x[i] < b.x[i] then a.dx[i]+=1;b.dx[i]-=1
        elsif a.x[i] > b.x[i] then a.dx[i]-=1;b.dx[i]+=1
        end
      end
      m.each { |m| m.x[i]+=m.dx[i] }
    end
  end
  m.map do |m|
    m.x.map(&:abs).sum *
    m.dx.map(&:abs).sum
  end.sum
end

day12_1("""<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>""",10) # should be 179

day12_1("""<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>""",100) # should be 1940

p day12_1(File.read('in/12.txt'),1000)



def day12_2(inp)
  m = inp.lines.map { |l| M.new(l.scan(/-?\d+/).map(&:to_i), [0]*3) }

  x,y,z = 3.times.map do |i|
    steps = 0
    loop do
      steps += 1
      m.combination(2).each do |(a,b)|
        if a.x[i] < b.x[i]
          a.dx[i] +=1
          b.dx[i] -=1
        elsif a.x[i] > b.x[i]
          a.dx[i] -=1
          b.dx[i] +=1
        end
      end
      m.each do |m|
        m.x[i] += m.dx[i]
      end
      break if m.all? { |m| m.dx[i].zero? }
    end
    steps
  end
  x.lcm(y).lcm(y.lcm(z)) * 2
end


s=Time.now;
day12_2("""<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>""") # should be 2772
Time.now-s

s=Time.now;
day12_2("""<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>""") # should be 4686774924
Time.now-s

s=Time.now;
p day12_2(File.read('in/12.txt'))
Time.now-s
