def day1_1(inp)
  puts inp.lines.map {|l| (l.strip.to_i/3).floor-2}.sum
end

day1_1("""12
14
1969
100756""") # should be 34241

day1_1(File.read('in/01.txt'))


def day1_2(inp)
  puts inp.lines.map do |l|
    s=l.strip.to_i
    t=0
    while s>0
      s=(s/3).floor-2
      t+=s if s>0
    end
    t
  end.sum
end

day1_2("""100756""") # should be 50346

day1_2(File.read('in/01.txt'))
