require './vm'

require 'curses'
include Curses

def prep_window
  init_screen
  start_color
  curs_set(0)
  noecho
  init_pair(0, COLOR_BLACK, COLOR_BLACK)
  init_pair(1, COLOR_GREEN, COLOR_BLACK)
  init_pair(2, COLOR_RED, COLOR_BLACK)
  Curses::Window.new(0, 0, 1, 2)
end

def move(vm, map, pos, win, m)
  r = vm.run([m])
  pos2 = pos+m2dir(m)
  raise "weird state #{r} moving #{m} to #{pos2}" if r.is_a? Symbol
  on_h2o = map[pos] == 0
  c, ch, c2, ch2 = case r
  when 0 then [1, 'D', 0, '#']
  when 1 then [on_h2o ? 2 : 0, on_h2o ? '$' : '.', 1, 'D']
  when 2 then [1, 'D', 2, '$']
  else raise "weird thing #{r} moving #{m} from #{pos} to #{pos2}"
  end
  win.setpos(pos.imag+20, pos.real+25)
  win.attron(color_pair(c)) { win.addch(ch) }
  win.setpos(pos2.imag+20, pos2.real+25)
  win.attron(color_pair(c2)) { win.addch(ch2) }
  win.refresh
  sleep 0.001
  r
end

def day17_1(inp)
  # win = prep_window
  vm = VM.new(inp)
  map = Hash.new('.')
  res = vm.run_to_end.map(&:chr).join('')
  res.split("\n").each_with_index do|row,y|
    row.split('').each_with_index{|c,x| map[Complex(x,y)]=c }
  end
  total = 0
  map.each{|l,c| total+=l.imag*l.real if [map[l+1],map[l-1],map[l+1i],map[l-1i]] == ['#']*4 }
  p total
ensure
  close_screen
end

day17_1(File.read('in/17.txt'))

def draw(map)
  x = Range.new(*map.keys.map(&:real).minmax)
  y = Range.new(*map.keys.map(&:imag).minmax)
  y.each{|y|x.each{|x|print map[Complex(x,y)]};puts}
end

def turns(dir)
  [[dir/1i, 'L'],[dir*1i, 'R']]
end

def walk(map, pos, dir)
  if map[pos+dir] == '#'
    rest = walk(map, pos+dir, dir)
    if rest[0].is_a? Integer
      [rest[0]+1] + rest[1..]
    else
      [1] + rest
    end
  else
    dir, ch = turns(dir).find {|(dir,_)| map[pos+dir] == '#'}
    return [] if dir.nil?
    [ch] + walk(map, pos, dir)
  end
end

def day17_2(inp)
  # win = prep_window
  vm = VM.new(inp)
  vm.set(0,2)
  map = Hash.new('.')
  res = vm.run_to_end
  res.map(&:chr).join('').split("\n").each_with_index do|row,y|
    row.split('').each_with_index{|c,x| map[Complex(x,y)]=c }
  end
  # draw(map)
  pos = map.rassoc('^').first
  dir = Complex(0,-1)
  puts "Solve by hand: "+ walk(map, pos, dir).join(',')
  # solve by hand :)
  a = "R,6,L,10,R,8\n".split('').map(&:ord)
  b = "R,8,R,12,L,8,L,8\n".split('').map(&:ord)
  c = "L,10,R,6,R,6,L,8\n".split('').map(&:ord)
  m = "A,B,A,B,C,A,B,C,A,C\n".split('').map(&:ord)
  p vm.run_to_end(m+a+b+c+['n'.ord,10]).last
ensure
  close_screen
end

day17_2(File.read('in/17.txt'))

