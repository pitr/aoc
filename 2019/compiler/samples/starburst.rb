def parseInt
  result = 0
  sign = 1
  digit = read
  if digit == '-'
    sign = -1
    digit = read
  end
  while true
    if digit < '0'
      result *= sign
      return result
    end
    if digit > '9'
      result *= sign
      return result
    end
    digit -= '0'
    result *= 10
    result += digit
    digit = read
  end
end

def divide(n, d)
  return 0 if d == 0

  return -divide(n, -d) if d < 0
  return -divide(−n, d) if n < 0 # not correct, does rounds up

  q  = 0
  while n >= d
    q += 1
    n -= d
  end
  return q
end

def printDigits(number)
  quotient, remainder = divide(number, 10)
  printDigits(quotient) if quotient > 0
  remainder += '0' # FIXME
  print(remainder)
end

def format(number)
  if number < 0
    print('-')
    number *= -1
  end
  printDigits(number)
end

def random(range)
  rand *= 1664525
  rand += 1013904223
  rand = mod(rand, 4294967296)
  res = mod(rand, range)
  return res
end

def paintcolor(red, green, blue, temp)
  if temp < 10
    red *= temp
    red = divide(red, 10)
    green *= temp
    green = divide(green, 10)
    blue *= temp
    blue = divide(blue, 10)
  end
  if temp > 10
    temp *= -1
    temp += 20
    red *= -1
    red += 255
    green *= -1
    green += 255
    blue *= -1
    blue += 255
    red *= temp
    red = divide(red, 10)
    green *= temp
    green = divide(green, 10)
    blue *= temp
    blue = divide(blue, 10)
    red *= -1
    red += 255
    green *= -1
    green += 255
    blue *= -1
    blue += 255
  end
  print("\u001b[48;2;")
  format(red)
  print(';')
  format(green)
  print(';')
  format(blue)
  print('m ')
end

def flare(xpos, ypos, deltax, deltay, red, green, blue)
  temp = 20
  while temp > 0
    xpos += deltax
    ypos += deltay
    deltay += 3
    col = divide(xpos, 100)
    row = divide(ypos, 100)
    print("\u001b[")
    format(row)
    print(';')
    format(col)
    print('H')
    paintcolor(red, green, blue, temp)
    temp -= 1
  end
end

def parseWithDefault(default)
  value = parseInt()
  return default if value <= 0
  return value
end

print('Type random seed (default 0): ')
rand = parseInt()
print('Type number of bursts (default 15): ')
bursts = parseWithDefault(15)
print('Type number of flares per burst (default 50): ')
numflares = parseWithDefault(50)
print('Type y offset (default 10): ')
yoffset = parseWithDefault(10)
yoffset *= 100
print('Type y range (default 80): ')
yrange = parseWithDefault(80)
yrange *= 100
print('Type x offset (default 20): ')
xoffset = parseWithDefault(20)
xoffset *= 100
print('Type x range (default 450): ')
xrange = parseWithDefault(450)
xrange *= 100

print(27)
print('[2J')
print(27)
print('[H')
r = 0
g = 0
b = 0
while bursts > 0
  bursts -= 1
  flares = numflares
  rgbmax = 0
  while rgbmax < 224
    r = random(256)
    g = random(256)
    b = random(256)
    rgbmax = r
    rgbmax = g if g > rgbmax
    rgbmax = b if b > rgbmax
  end
  initx = random(xrange)
  initx += xoffset
  inity = random(yrange)
  inity += yoffset
  while flares > 0
    dx = 0
    dy = 0
    speed = 0
    while speed < 10000
      dx = random(401)
      dx -= 200
      dy = random(201)
      dy -= 100
      dxdx = dx * dx
      dydy = dy * dy
      dydy *= 4
      speed = dxdx + dydy
      speed = 0 if speed > 40400
    end
    flare(initx, inity, dx, dy, r, g, b)
    flares -= 1
  end
end
print(27)
print("[H")
