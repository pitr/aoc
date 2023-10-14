def day1_1(inp)
  h={}
  inp.lines.each {|l| h[l.strip.to_i]=true}
  h.each_key { |k| return k*(2020-k) if h[2020-k] }
end

puts day1_1(File.read("in/01e.txt")) # should be 514579

puts day1_1(File.read('in/01.txt'))


def day1_2(inp)
  h={}
  inp.lines.each {|l| h[l.strip.to_i]=true}
  h.each_key { |a| h.each_key { |b|
    next if a==b || a+b>=2020
    return a*b*(2020-a-b) if h[2020-a-b]
  }}
end

puts day1_2(File.read("in/01e.txt")) # should be 241861950

puts day1_2(File.read('in/01.txt'))
