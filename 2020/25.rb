dp,cp = File.read("25.txt").split.map(&:to_i)

def find_loop(s,t,v=1,l=0)
    until v==t
        l+=1; v = (v*s) % 20201227
    end
    l
end

def run(s,t,v=1)
    t.times { v = (v*s) % 20201227 }
    v
end

dl = find_loop(7,dp)

p run(cp,dl)