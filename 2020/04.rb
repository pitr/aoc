require 'set'
K = 'byr iyr eyr hgt hcl ecl pid'.split

def day4_1(inp)
  inp.split("\n\n").select{|s|K.all?{|kk|s.include?(kk)}}.count
end

puts day4_1(File.read('in/04e.txt')) # should be 9
puts day4_1(File.read('in/04.txt'))


def day4_2(inp)
  eyes = 'amb blu brn gry grn hzl oth'.split.to_set
  inp.split("\n\n").map { |l| l.split.join(' ') }.select { |l|
    h = l.split.map{|x|x.split(?:)}.to_h
    next unless K.all?{|k|h.has_key? k}
    next unless (1920..2002).include?(h['byr'].to_i)
    next unless (2010..2020).include?(h['iyr'].to_i)
    next unless (2020..2030).include?(h['eyr'].to_i)
    next unless h['hgt'].match?('(cm|in)$')
    next if h['hgt'].end_with?('cm') && ! (150..193).include?(h['hgt'].to_i)
    next if h['hgt'].end_with?('in') && ! (59..76).include?(h['hgt'].to_i)
    next unless h['hcl'].match?(/^#[0-9a-f]{6}$/)
    next unless eyes.include?(h['ecl'])
    next unless h['pid'].match?(/^\d{9}$/)
    true
  }.count
end

puts day4_2(File.read('in/04e.txt')) # should be 4
puts day4_2(File.read('in/04.txt'))
