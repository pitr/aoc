require './vm'

def day13_1(inp)
  m = VM.new(inp)
  map = Hash.new(0)
  loop do
    x, y, t = [m.run, m.run, m.run]
    break if x.is_a? Symbol
    map[Complex(x,y)] = t
  end
  map.values.count(2)
end

# day13_1(File.read('13.txt'))


def day13_2(inp)
  require 'curses'
  include Curses
  init_screen
  start_color
  curs_set(0)
  noecho
  init_pair(0, COLOR_BLACK, COLOR_BLACK)
  init_pair(1, COLOR_GREEN, COLOR_BLACK)
  init_pair(2, COLOR_RED, COLOR_BLACK)
  win = Curses::Window.new(0, 0, 1, 2)

  m = VM.new(inp)
  m.set(0, 2)
  map = Hash.new(0)
  def run(m, map, win, input)
    loop do
      x, y, t = [m.run(Array(input.shift)), m.run(Array(input.shift)), m.run(Array(input.shift))]
      break if x.is_a? Symbol
      map[Complex(x,y)] = t
      if Complex(x,y) == -1
        win.setpos(0, 0)
        win.attron(color_pair(0)) { win.addstr("Score #{t}") }
        next
      end
      win.setpos(y, x)
      c, ch = case t
        when 0,nil then [0, ' ']
        when 1 then [0, '#']
        when 2 then [1, '%']
        when 3 then [2, '-']
        when 4 then [2, '0']
        else raise "weird thing #{t} at #{x},#{y}"
      end
      win.attron(color_pair(c)) { win.addch(ch) }
    end
    win.refresh
  end
  run(m, map, win, [])
  loop do
    c = map.rassoc(4).first.real <=> map.rassoc(3).first.real
    run(m, map, win, [c])
    sleep 0.03
    break if map.values.count(2) == 0
  end
  close_screen
  puts "Final score #{map[Complex(-1,0)]}"
ensure

end

day13_2(File.read('13.txt'))
