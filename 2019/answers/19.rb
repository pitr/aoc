require './vm'

def day19_1(inp)
  total = 0
  50.times do |y|
    50.times do |x|
      total+=1 if 1==VM.new(inp).run([x,y])
    end
  end
  puts total
end

day19_1(File.read('19.txt'))

def day19_2(inp)
  x=500
  y=500
  loop do
    if 1==VM.new(inp).run([x,y])
      if 1==VM.new(inp).run([x-99,y+99])
        puts (x - 99) * 10_000 + y
        return
      else
        x+=1
      end
    else
      y+=1
    end
  end
end

day19_2(File.read('19.txt'))
