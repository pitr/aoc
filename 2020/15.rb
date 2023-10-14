N = File.read("in/15.txt").split(',').map(&:to_i)

def solve(n)
    last = N.last
    mem = Array.new(n)
    N[0...-1].each_with_index { |e, i| mem[e] = i.succ }
    (N.size...n).each do |i|
        mem[last], last = i, mem[last].nil? ? 0 : i - mem[last]
    end
    p last
end

solve 2020
solve 30000000