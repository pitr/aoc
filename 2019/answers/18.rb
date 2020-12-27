require 'set'

DIRS = 4.times.map{|x|1i**x}.freeze

def walk(inp, convert=false)
  map = Hash.new('#')
  kk = {}
  start = {}
  k2k = {}

  if convert
    lines = inp.chomp.split("\n")
    lines.each_with_index do |row,y|
      row.split('').each_with_index do |c,x|
        if c == '@'
          lines[y-1][x-1..x+1] = lines[y+1][x-1..x+1] = '@#@'
          lines[y][x-1..x+1] = '###'
          return walk(lines.join("\n"))
        end
      end
    end
  end
  inp.chomp.split("\n").each_with_index do |row,y|
    row.split('').each_with_index do |c,x|
      pos = Complex(x,y)
      map[pos] = c
      kk[c] = pos if c.match?(/[a-z]/)
      start["@#{start.size}"] = pos if c == '@'
    end
  end
  kk.merge(start).each do |key, key_pos|
    queue = [ [*key_pos, []] ]
    distance = { key_pos => 0 }
    keys = []
    while not queue.empty?
      from, needed_keys = queue.shift
      DIRS.each do |dir|
        pos = from+dir
        tile = map[pos]
        next if tile == '#'
        next if distance.has_key?(pos)
        distance[pos] = distance[from] + 1
        if tile.match?(/[a-z]/)
          keys << [ tile, needed_keys, distance[pos] ]
        end
        if tile.match?(/[A-Za-z]/)
          queue << [pos, needed_keys + [tile.downcase]]
        else
          queue << [pos, needed_keys]
        end
      end
    end
    k2k[key] = keys
  end
  return start, k2k
end

def reachable_keys(k2k, pos, unlocked = [])
  keys = []
  pos.each_with_index do |from_key, runner|
    k2k[from_key].each do |key, needed_keys, distance|
      next if unlocked.include?(key)
      next unless (needed_keys - unlocked).empty?
      keys << [ runner, key, distance ]
    end
  end
  return keys
end

def min_steps(k2k, pos, unlocked = [], cache = {})
  cache_key = [pos.sort.join, unlocked.sort.join]
  if not cache.has_key?(cache_key)
    keys = reachable_keys(k2k, pos, unlocked)
    if keys.empty?
      val = 0
    else
      steps = []
      keys.each do |runner, key, distance|
        orig = pos[runner]
        pos[runner] = key
        steps << distance + min_steps(k2k, pos, unlocked + [key], cache)
        pos[runner] = orig
      end
      val = steps.min
    end
    cache[cache_key] = val
  end
  return cache[cache_key]
end

def day18_1(inp)
  start, k2k = walk(inp)
  puts min_steps(k2k, start.keys)
end


def day18_2(inp)
  start, k2k = walk(inp, true)
  puts min_steps(k2k, start.keys)
end



puts "should be 132: "
day18_1(<<-END)
...............b.C.D.f
.#####################
.....@.a.B.c.d.A.e.F.g
END

puts "should be 136: "
day18_1(<<-END)
i.G..c...e..H.p
#######.#######
j.A..b...f..D.o
#######@#######
k.E..a...g..B.n
#######.#######
l.F..d...h..C.m
END

puts "should be 81"
day18_1(<<-END)
@..............ac.GI.b#
##d#e#f################
##A#B#C################
##g#h#i################
END

day18_1(File.read('18.txt'))

puts "should be 8"
day18_2(<<-END)
a.#Cd
#...#
#.@.#
#...#
cB#Ab
END

puts "should be 24"
day18_2(<<-END)
d.ABC.#.....a
#####...#####
#####.@.#####
#####...#####
b.....#.....c
END

puts "should be 32"
day18_2(<<-END)
DcBa.#.GhKl
.###...#I##
e#d#.@.#j#k
##C#...###J
fEbA.#.FgHi
END

puts "should be 72"
day18_2(<<-END)
g#f.D#..h#l
F###e#E###.
dCba...BcIJ
####.@.####
nK.L...G...
M###N#H###.
o#m..#i#jk.
END

day18_2(File.read('18.txt'))
