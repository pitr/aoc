input = File.read("16.txt").split("\n\n")

rules = input[0].lines.map do |l|
    m = l.split(?:)
    [m.first, m.last.scan(/(\d+)-(\d+)/).map{|(x,y)|x.to_i..y.to_i}]
end.to_h

mine = input[1].lines.last.split(?,).map(&:to_i)

tickets = input[2].lines[1..].map {|l| l.split(',').map(&:to_i) }

p tickets.flatten.select {|n| rules.all?{|(_,rs)|rs.none?{|r|r===n}}}.sum

valid_tickets = tickets.reject {|t| t.any? {|n| rules.all?{|(_,rs)| rs.none?{|r|r===n}} }}

pos = rules.map do |name, rs|
    [name, rules.count.times.select {|i| valid_tickets.all? {|t| rs.any? {|r| r===t[i] }}}]
end.sort_by { |_, positions| positions.count }

ix = pos.map do |(name, num)|
    num = num.first
    pos.each { |_, p| p.delete(num) }
    num if name.start_with?("departure")
end.compact

p mine.values_at(*ix).reduce(:*)