require 'set'

d = File.read("22.txt").split("\n\n").map { |s| s.lines[1..].map(&:to_i) }

$game_id = 0

def solve(d, part2: false)
    seen = Set.new
    round = 1
    game = $game_id += 1

    until d.map(&:size).include?(0)
        sig = d.map{|x|x.join(':')}.join(?;)
        return true if part2 && seen.include?(sig)
        seen << sig if part2
        p,q = d.map(&:shift)
        winner = if part2 && d[0].size >= p && d[1].size >= q
            ds = [d[0].take(p), d[1].take(q)]
            ds.map(&:max).reduce(:>) or solve(ds, part2: part2)
        else
            p>q
        end
        if winner
            d[0].push(p,q)
        else
            d[1].push(q,p)
        end
        round+=1
    end
    return d.first.size>0
end

d1 = d.map(&:dup)
solve(d1)
p d1.flatten.reverse.each_with_index.map { |n, i| n*i.succ }.sum

d2 = d.map(&:dup)
solve(d2, part2: true)
p d2.flatten.reverse.each_with_index.map { |n, i| n*i.succ }.sum