A = {}
I = Hash.new { |hsh, key| hsh[key] = 0 }

File.read("21.txt").lines.each do |l|
    w=l.scan(/(\w+)/).flatten
    ix=w.index('contains')
    is,as = w[0...ix],w[ix.succ..]
    is.each { |i| I[i] += 1 }
    as.each { |a| A[a] = (A[a] ||= is) & is }
end

good = I.keys - A.values.flatten.uniq
p good.inject(0) { |mem, i| mem + I[i] }

while A.values.any? { |is| is.size > 1 }
    isolated = A.values.select { |is| is.size == 1 }.flatten
    A.each { |_,is| isolated.each { |i| is.delete(i) if is.size>1 } }
end

puts A.map { |k,v| [k,v.first] }.sort_by(&:first).map(&:last).join(?,)