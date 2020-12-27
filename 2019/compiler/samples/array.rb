def x
  return 3
end

data = [0, 1, 0, -1]
print '0' + data[3]

memory = Array.new(1024)

a=5
b=6
c=a+b

memory[99] = x + c
print '0' + memory[99]
