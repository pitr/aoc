class Complex
  def dist
    self.real.abs + self.imaginary.abs
  end
  def points_to(vec, cost=-1)
    result = if !vec.real.zero? && !vec.imaginary.zero?
      raise 'non-perpendicular vectors are not supported'
    elsif !vec.real.zero?
      steps = vec.real.abs
      1.upto(steps).map { |i| [self + Complex(i*vec.real/steps,0), cost+i] }
    elsif !vec.imaginary.zero?
      steps = vec.imaginary.abs
      1.upto(steps).map { |i| [self + Complex(0,i*vec.imaginary/steps), cost+i] }
    else
      []
    end
    return result.map(&:first) if cost == -1
    result
  end
end

def day3_1(inp)
  a,b=inp.lines.take(2).map do |row|
    row.strip.split(',').map do |pos|
      dir,n = pos.split('',2)
      case dir
      when 'R' then Complex(n.to_i,0)
      when 'L' then Complex(-n.to_i,0)
      when 'U' then Complex(0,n.to_i)
      when 'D' then Complex(0,-n.to_i)
      else raise "unknown direction #{dir}"
      end
    end.inject([Complex(0,0)]) do |path, vec|
      path + path.last.points_to(vec)
    end
  end
  (a[1..]&b[1..]).map(&:dist).min
end

day3_1("""R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83""") # should be 159
day3_1("""R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7""") # should be 135

puts day3_1(File.read('in/03.txt'))



def day3_2(inp)
  a,b=inp.lines.take(2).map do |row|
    row.strip.split(',').map do |pos|
      dir,n = pos.split('',2)
      case dir
      when 'R' then Complex(n.to_i,0)
      when 'L' then Complex(-n.to_i,0)
      when 'U' then Complex(0,n.to_i)
      when 'D' then Complex(0,-n.to_i)
      else raise "unknown direction #{dir}"
      end
    end.inject([[Complex(0,0),0]]) do |path, vec|
      pos, cost = path.last
      path + pos.points_to(vec, cost)
    end
  end
  aa = {}
  bb = {}
  a[1..].each{|(k,v)|aa[k]=[aa[k],v].compact.min}
  b[1..].each{|(k,v)|bb[k]=[bb[k],v].compact.min}
  (aa.keys&bb.keys).map {|pos|aa[pos]+bb[pos]}.min
end

day3_2("""R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83""") # should be 610
day3_2("""R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7""") # should be 410

puts day3_2(File.read('in/03.txt'))
