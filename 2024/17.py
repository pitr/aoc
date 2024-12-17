import z3
import re
opt = z3.Optimize()
s = z3.BitVec('s', 64)
a, b, c = s, 0, 0
n = list(map(int, re.findall(r'\d', open('in/17.txt').readlines()[-1])))
for x in n:
    opt.add(a != 0)
    b = n[3] ^ a%8
    b = n[9] ^ b ^ a>>b
    opt.add((b%8) == x)
    a = a>>3
opt.add(a == 0)
opt.minimize(s)
assert str(opt.check()) == 'sat'
print(opt.model().eval(s))
