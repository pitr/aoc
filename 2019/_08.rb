def day8_1(inp, w, h)
  layers = inp.strip.split('').each_slice(w*h).to_a
  layer = layers.min_by {|l| l.count('0')}
  layer.count('1') * layer.count('2')
end

day8_1("""123456789012""", 3, 2)

day8_1(File.read('in/08.txt'), 25, 6)


def day8_2(inp, w, h)
  layers = inp.strip.split('').each_slice(w*h).to_a
  r=('2'*(w*h)).split('').zip(*layers).map {|pp| pp.find{|p|p=='0'||p=='1'}}
  r.each_slice(w).map{|r|puts r.join('').tr('01',' X')};42
end

day8_2("""0222112222120000""", 2, 2)

day8_2(File.read('in/08.txt'), 25, 6)
