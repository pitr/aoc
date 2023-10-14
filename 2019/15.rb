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
def m2dir(m)
  case m
  when 1 then Complex(0, 1)
  when 2 then Complex(0, -1)
  when 3 then Complex(-1)
  when 4 then Complex(1)
  else raise "unknown m=#{m}"
  end
end
def m2back(m)
  case m
  when 0 then 0
  when 1 then 2
  when 2 then 1
  when 3 then 4
  when 4 then 3
  else raise "unknown m=#{m}"
  end
end
def solve(vm, map, pos, win, moves, back, &block)
  mm = (1..4).to_a - [back]
  mm.each do |m|
    r = move(vm, map, pos, win, m)
    next if r == 0 # do nothing

    pos2 = pos+m2dir(m)

    if r == 2
      block.call(pos2, moves+1)
    end
    raise "unknown value moving #{m} from #{pos} = #{r}" unless [1,2].include?(r)

    pos2 = pos+m2dir(m)
    map[pos2] = r == 2 ? 0 : :valid
    solve(vm, map, pos2, win, moves+1, m2back(m), &block)
    # finished exploring that direction, try another
  end
  # no moves left, move back
  return if back == 0
  r = move(vm, map, pos, win, back)
  raise "back propogation failed with #{r}" if r != 1
end

def solve2(map, pos, win, minute)
  map[pos] = minute
  win.setpos(pos.imag+20, pos.real+25)
  win.attron(color_pair(2)) { win.addch('O') }

  mm = (1..4).to_a
  mm.each do |m|
    pos2 = pos+m2dir(m)
    next if map[pos2] != :valid
    solve2(map, pos2, win, minute+1)
  end

  win.refresh
  sleep 0.01
end

def day15_1(inp)
  win = prep_window
  vm = VM.new(inp)
  map = {}
  solve(vm, map, Complex(0,0), win, 0, 0) do |pos, moves|
    sleep 2
    raise "Found oxygen at #{pos} after #{moves}"
  end
rescue Exception => e
  close_screen
  p e
ensure
  close_screen
end

# day15_1(File.read('in/15.txt'))

H2O = []

def day15_2(inp)
  win = prep_window
  vm = VM.new(inp)
  map = {}
  solve(vm, map, Complex(0,0), win, 0, 0) do |pos, moves|
    H2O << pos << moves
  end
  raise "no oxigen found" if H2O.size == 0
  solve2(map, H2O[0], win, 0)
  close_screen
  puts "found oxygen at #{H2O[0]} after #{H2O[1]}"
  puts "max oxygen found was at #{map.values.max}"
ensure
  close_screen
end

day15_2(File.read('in/15.txt'))
