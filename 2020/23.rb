seed = File.read("23.txt").chars.map(&:to_i)


class Cups
    def initialize(seed, it, n=nil)
        @n = n ||= seed.size
        @cups = Array.new(n.succ) do |i|
            if i.zero?
                seed[0]
            elsif i <= seed.size
                if i == seed.last
                    if n==seed.size
                        seed[0]
                    else
                        seed.size.succ
                    end
                else
                    seed[seed.index(i).succ]
                end
            elsif i==n
                seed[0]
            else
                i.succ
            end
        end

        curr = @cups[0]

        it.times do
            dest = curr - 1
            d = @cups[c = @cups[b = @cups[a = @cups[curr]]]]

            dest = @n if dest == 0

            while [a,b,c].include?(dest)
                dest -= 1
                dest = @n if dest == 0
            end

            curr = @cups[curr] = d
            @cups[c] = @cups[dest]
            @cups[dest] = a
        end
    end

    def take(n=@n-1, curr=1)
        n.times.map { curr = @cups[curr] }
    end
end

puts Cups.new(seed, 100).take.join
puts Cups.new(seed, 1e7.to_i, 1e6.to_i).take(2).inject(:*)