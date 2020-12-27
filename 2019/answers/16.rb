PATTERN = [0, 1, 0, -1].freeze

def day16_1(inp)
  d = inp.strip.split('').map(&:to_i)
  100.times do
    d = d.size.times.map do |i|
      d.each_with_index.map do |n, j|
        n * PATTERN[((j + 1) / (i + 1)) % PATTERN.size]
      end.sum.abs % 10
    end
  end

  d.take(8).join('')
end

p day16_1("80871224585914546619083218645595") # should be 24176176
p day16_1("19617804207202209144916044189917") # should be 73745418
p day16_1("69317163492948606335995924319873") # should be 52432133

s = Time.now
p day16_1(File.read('16.txt'))
puts "Done in #{Time.now-s}s"

def day16_2(inp)
  d = inp.strip.split('').map(&:to_i) * 10_000
  offset = d.take(7).join('').to_i
  100.times do
    partial = d[offset..].sum
    offset.upto(d.size-1) do |i|
      n = partial
      partial -= d[i]
      d[i] = n.abs % 10
    end
  end
  d[offset,8].join('')
end

p day16_2('03036732577212944063491565474664') # should be 84462026
p day16_2('02935109699940807407585447034323') # should be 78725270
p day16_2('03081770884921959731165446850517') # should be 53553731


s = Time.now
p day16_2(File.read('16.txt'))
puts "Done in #{Time.now-s}s"
