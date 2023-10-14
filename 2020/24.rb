require 'set'

l = File.read("in/24.txt").lines.map(&:chomp)

m = Hash.new(0)

def walk(s)
    x=y=i=0
    until i==s.size
        xd, yd, shift = case s[i..i.succ]
        when /^w.*/ then [-1,0,1]
        when /^e.*/ then [1,0,1]
        when /^nw.*/ then [-1,-1,2]
        when /^ne.*/ then [0,-1,2]
        when /^sw.*/ then [0,1,2]
        when /^se.*/ then [1,1,2]
        else raise 'invalid input'
        end
        i+=shift
        x+=xd
        y+=yd
    end
    return [x,y]
end

l.each do |l|
    x=y=0

    xd,yd=walk(l)
    x+=xd
    y+=yd
    if m.has_key?([x,y])
        m.delete([x,y])
    else
        m[[x,y]] = 1
    end
end

p m.size

DIR = ['w','e','se','sw','ne','nw']

100.times do
    mp = Hash.new(0)
    white_to_check = Set.new
    m.keys.each do |x,y|
        nbs = DIR.map do |s|
            xp,yp=walk(s)
            t=m[[x+xp,y+yp]]
            white_to_check<<[x+xp,y+yp] if t==0
            t
        end
        mp[[x,y]] = 1 if (1..2) === nbs.sum
    end
    white_to_check.each do |x,y|
        nbs = DIR.map do |s|
            xp,yp=walk(s)
            m[[x+xp,y+yp]]
        end
        mp[[x,y]] = 1 if 2 == nbs.sum
    end
    m = mp
end

p m.size