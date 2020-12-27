def day2_1(inp)
  c=inp.strip.split(',').map(&:to_i)
  c[1]=12
  c[2]=2
  (c.length/4).times do |i|
    op,x,y,z=c[i*4, 4]
    p "op=#{op} x=#{x} y=#{y} z=#{z}"
    case op
    when 1 then c[z]=c[x]+c[y]
    when 2 then c[z]=c[x]*c[y]
    when 99 break
    else raise "unknown op #{op}"
    end
  end
  c[0]
end

day2_1("1,0,0,0,99") # should be 2
day2_1("2,3,0,3,99") # should be 2
day2_1("") # should be
day2_1("1,1,1,4,99,5,6,0,99") # should be 30

day2_1(File.read('2.txt'))



def day2_2(inp)
  0.upto(99) do |noun|
    0.upto(99) do |verb|
      val = run(inp, noun, verb) rescue nil
      p "invalid input #{noun} #{verb}" if val.nil?
      return 100 * noun + verb if val == 19690720
    end
  end
end

def run(inp,a,b)
  c=inp.strip.split(',').map(&:to_i)
  c[1]=a
  c[2]=b
  (c.length/4).times do |i|
    op,x,y,z=c[i*4, 4]
    case op
    when 1 then c[z]=c[x]+c[y]
    when 2 then c[z]=c[x]*c[y]
    when 99 then break
    else raise "unknown op #{op}"
    end
  end
  c[0]
end

day2_2(File.read('2.txt'))
