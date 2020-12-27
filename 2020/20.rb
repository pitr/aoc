class Tile
    attr_reader :n
    attr_accessor :m
    def initialize(text)
        n,m=text.split(":\n")
        @n = n.split.last.to_i
        @m = m.split(?\n).map { |l| l.split('') }
    end
    def left_all
        @m.transpose.first
    end
    def right
        r = @m.transpose.last.join('')
        T.find_match_for(self) { |m| m.transpose.first.join('') == r }
    end
    def left
        r = @m.transpose.first.join('')
        T.find_match_for(self) { |m| m.transpose.last.join('') == r }
    end
    def down
        r = @m.last.join('')
        T.find_match_for(self) { |m| m.first.join('') == r }
    end
    def up
        r = @m.first.join('')
        T.find_match_for(self) { |m| m.last.join('') == r }
    end
end

T = File.read("20.txt").split("\n\n").map { |t| Tile.new(t) }


POS = 4.times.map {|i|[:transpose,:reverse,:mirror].combination(i).to_a}.flatten(1)
def T.find_match_for(other)
    self.each do |t|
        next if t==other
        POS.each do |pos|
            m = t.m
            m = m.transpose if pos.include? :transpose
            m = m.reverse if pos.include? :reverse
            m = m.map(&:reverse) if pos.include? :mirror
            if yield m
                t.m = m
                return t
            end
        end
    end
    return :edge
end

M = {}

def compute(x,y,t)
    M[[x,y]] = t
    return if t == :edge
    compute(x+1,y,t.right)  if M[[x+1,y]].nil?
    compute(x-1,y,t.left)   if M[[x-1,y]].nil?
    compute(x,y-1,t.up)     if M[[x,y-1]].nil?
    compute(x,y+1,t.down)   if M[[x,y+1]].nil?
end

compute(0,0, T.first)
M.keep_if{|_,v|v!=:edge}

x1,x2 = M.keys.map(&:first).minmax
y1,y2 = M.keys.map(&:last).minmax

p [x1,x2].product([y1,y2]).map { |x,y| M[[x,y]].n }.inject(:*)



map = (y1..y2).map do |y|
    (x1..x2).map do |x|
        M[[x,y]].m[1...-1].map{|l|l[1...-1]}
    end.inject { |lhs, rhs| lhs.zip(rhs).map { |l,r| [l,r].flatten } }
end.inject(:+).transpose.reverse.map(&:reverse)

monster = [/(?=(..................#.))/,
           /(?=(#....##....##....###))/,
           /(?=(.#..#..#..#..#..#...))/]
monster_size = monster.map{|r|r.to_s.count(?#)}.sum

monsters = (0...map.size-monster.size).map do |y|
    3.times.map do |i|
        map[y+i].join.enum_for(:scan, monster[i]).map { Regexp.last_match.begin(0) }
    end.inject(:&).size
end.sum

p map.map { |l| l.count('#') }.sum - monsters*monster_size