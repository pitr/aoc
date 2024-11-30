require 'set'

def find_portals(lines)
  lines[2..-3].each_with_index do |row,y|
    offset = 0
    while ix = row.index(/[[:upper:]]{2}/, offset)
      offset = ix + 1
      name = Regexp.last_match[0]
      if row[ix,3] == "#{name}."
        yield name, ix+2, y+2, (ix < row.length/2) ? -1 : 1
      elsif row[ix-1,3] == ".#{name}"
        yield name, ix-1, y+2, (ix < row.length/2) ? 1 : -1
      else
        raise "Weird #{name} at #{ix},#{y}"
      end
    end
  end
end

def turns
  4.times.map{|x|1i**x}
end

def walk(map, portals, levels, pos, back=[], steps=0)
  (turns-back).map do |dir|
    c = map[pos+dir]
    next if c != '.'
    if portals.has_key?(pos+dir)
      [portals[pos+dir], steps+1, levels[pos+dir]]
    else
      walk(map, portals, levels, pos+dir, [-dir], steps+1)
    end
  end.compact
end

def prep(inp)
  map = Hash.new('#')
  entrances = {}
  levels = {}
  portals = {}
  distances = {}

  lines = inp.chomp.split("\n")
  lines.each_with_index do|row,y|
    row.split('').each_with_index do |c,x|
      map[Complex(x,y)] = c if c == '.'
    end
  end

  find_portals(lines) do |name, x, y, level|
    entrances[name] ||= []
    entrances[name] << Complex(x,y)
    levels[Complex(x,y)] = level
  end
  find_portals(lines.map(&:chars).transpose.map(&:join)) do |name, y, x, level|
    entrances[name] ||= []
    entrances[name] << Complex(x,y)
    levels[Complex(x,y)] = level
  end
  entrances.each do |key, poss|
    if poss.size > 1
      poss.each_cons(2) { |p1, p2| portals[p1] = p2; portals[p2] = p1 }
    else
      p1 = poss.first
      portals[p1] = p1
    end
  end

  entrances.each do |key, poss|
    poss.each do |pos|
      res = walk(map, portals, levels, pos).flatten.each_slice(3).to_a
      res.select! { |(pos, distance, level)| pos != entrances['AA'].first }
      distances[pos] = res
    end
  end

  return map, entrances, distances, levels
end

def day20_1(inp)
  map, entrances, distances, _ = prep(inp)

  bfs = {}
  bfs[entrances['AA'].first] = 0
  loop do
    pos, dist = bfs.min_by(&:last)
    bfs.delete(pos)
    return dist-1 if entrances['ZZ'].first == pos
    distances[pos].each do |(k,d,_)|
      if bfs.has_key?(k)
        bfs[k] = [bfs[k], dist+d+1].min
      else
        bfs[k] = dist+d+1
      end
    end
  end
end

def day20_2(inp)
  map, entrances, distances, levels = prep(inp)
  bfs = [[entrances['AA'].first, 0, 0]] # pos, level, distance
  loop do
    option = bfs.min_by(&:last)
    bfs.delete(option)
    pos, level, dist = option
    return dist-1 if level < 0
    distances[pos].each do |(k, d, level_change)|
      next if level > 0 && k == entrances['ZZ'].first
      next if level == 0 && k != entrances['ZZ'].first && level_change == -1
      bfs << [k, level+level_change, dist+d+1]
    end
  end
end



print "should be 23: "
p day20_1(<<END)
         A            #
         A            #
  #######.#########   #
  #######.........#   #
  #######.#######.#   #
  #######.#######.#   #
  #######.#######.#   #
  #####  B    ###.#   #
BC...##  C    ###.#   #
  ##.##       ###.#   #
  ##...DE  F  ###.#   #
  #####    G  ###.#   #
  #########.#####.#   #
DE..#######...###.#   #
  #.#########.###.#   #
FG..#########.....#   #
  ###########.#####   #
             Z        #
             Z        #
END

print "should be 58: "
p day20_1(<<END)
                   A               #
                   A               #
  #################.#############  #
  #.#...#...................#.#.#  #
  #.#.#.###.###.###.#########.#.#  #
  #.#.#.......#...#.....#.#.#...#  #
  #.#########.###.#####.#.#.###.#  #
  #.............#.#.....#.......#  #
  ###.###########.###.#####.#.#.#  #
  #.....#        A   C    #.#.#.#  #
  #######        S   P    #####.#  #
  #.#...#                 #......VT#
  #.#.#.#                 #.#####  #
  #...#.#               YN....#.#  #
  #.###.#                 #####.#  #
DI....#.#                 #.....#  #
  #####.#                 #.###.#  #
ZZ......#               QG....#..AS#
  ###.###                 #######  #
JO..#.#.#                 #.....#  #
  #.#.#.#                 ###.#.#  #
  #...#..DI             BU....#..LF#
  #####.#                 #.#####  #
YN......#               VT..#....QG#
  #.###.#                 #.###.#  #
  #.#...#                 #.....#  #
  ###.###    J L     J    #.#.###  #
  #.....#    O F     P    #.#...#  #
  #.###.#####.#.#####.#####.###.#  #
  #...#.#.#...#.....#.....#.#...#  #
  #.#####.###.###.#.#.#########.#  #
  #...#.#.....#...#.#.#.#.....#.#  #
  #.###.#####.###.###.#.#.#######  #
  #.#.........#...#.............#  #
  #########.###.###.#############  #
           B   J   C               #
           U   P   P               #
END

p day20_1(File.read('in/20.txt'))



print "should be 26: "
p day20_2(<<END)
         A            #
         A            #
  #######.#########   #
  #######.........#   #
  #######.#######.#   #
  #######.#######.#   #
  #######.#######.#   #
  #####  B    ###.#   #
BC...##  C    ###.#   #
  ##.##       ###.#   #
  ##...DE  F  ###.#   #
  #####    G  ###.#   #
  #########.#####.#   #
DE..#######...###.#   #
  #.#########.###.#   #
FG..#########.....#   #
  ###########.#####   #
             Z        #
             Z        #
END

print "should be 396: "
p day20_2(<<END)
             Z L X W       C                 #
             Z P Q B       K                 #
  ###########.#.#.#.#######.###############  #
  #...#.......#.#.......#.#.......#.#.#...#  #
  ###.#.#.#.#.#.#.#.###.#.#.#######.#.#.###  #
  #.#...#.#.#...#.#.#...#...#...#.#.......#  #
  #.###.#######.###.###.#.###.###.#.#######  #
  #...#.......#.#...#...#.............#...#  #
  #.#########.#######.#.#######.#######.###  #
  #...#.#    F       R I       Z    #.#.#.#  #
  #.###.#    D       E C       H    #.#.#.#  #
  #.#...#                           #...#.#  #
  #.###.#                           #.###.#  #
  #.#....OA                       WB..#.#..ZH#
  #.###.#                           #.#.#.#  #
CJ......#                           #.....#  #
  #######                           #######  #
  #.#....CK                         #......IC#
  #.###.#                           #.###.#  #
  #.....#                           #...#.#  #
  ###.###                           #.#.#.#  #
XF....#.#                         RF..#.#.#  #
  #####.#                           #######  #
  #......CJ                       NM..#...#  #
  ###.#.#                           #.###.#  #
RE....#.#                           #......RF#
  ###.###        X   X       L      #.#.#.#  #
  #.....#        F   Q       P      #.#.#.#  #
  ###.###########.###.#######.#########.###  #
  #.....#...#.....#.......#...#.....#.#...#  #
  #####.#.###.#######.#######.###.###.#.#.#  #
  #.......#.......#.#.#.#.#...#...#...#.#.#  #
  #####.###.#####.#.#.#.#.###.###.#.###.###  #
  #.......#.....#.#...#...............#...#  #
  #############.#.#.###.###################  #
               A O F   N                     #
               A A D   M                     #
END

p day20_2(File.read('in/20.txt'))