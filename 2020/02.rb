def day2_1(inp)
  inp.lines.sum {|l|
    lo,hi,r,_,p=l.strip.split(/[-: ]/)
    c=p.count(r)
    c>=lo.to_i && c<=hi.to_i ? 1 : 0
  }
end

puts day2_1(File.read('02e.txt')) # should be 2
puts day2_1(File.read('02.txt'))


def day2_2(inp)
  inp.lines.sum {|l|
    lo,hi,r,_,p=l.strip.split(/[-: ]/)
    (p[lo.to_i-1]==r) ^ (p[hi.to_i-1]==r) ? 1 : 0
  }
end

puts day2_2(File.read('02e.txt')) # should be 1
puts day2_2(File.read('02.txt'))
