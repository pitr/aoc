import urllib.request
from collections import deque
from math import sqrt, floor
from functools import cached_property
import sys

sys.setrecursionlimit(100000)

def base94_to_int(s):
	num=0
	for char in s: num = num*94 + (ord(char)-33)
	return num

def int_to_base94(num):
	if num == 0: return "!"
	chars=[]
	while num:
		chars.append(chr(num%94 + 33))
		num //= 94
	return ''.join(reversed(chars))

def communicate(e, noparse=False):
	if isinstance(e, str): e = S(e)
	h = {'Authorization': 'Bearer GET-YOUR-OWN'}
	e = e.compile().encode()
	req = urllib.request.Request("https://boundvariable.space/communicate", data=e, headers=h)
	data = urllib.request.urlopen(req).read().decode("utf-8")
	if noparse: return data
	return Parser(data).parse()


alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[\\]^_`|~ \n"

class RawICFP:
	def __init__(self, expr): self.expr = expr
	def __repr__(self): return f"Raw('{self.expr}')"
	def lisp(self): raise Exception("cannot lisp raw expression")
	def compile(self): return self.expr
	def beta(self, var, val): raise Exception("cannot beta-reduce raw expression")

class Bool:
	def __init__(self, val): self.val = val
	def __repr__(self): return "Bool(True)" if self.val == True else "Bool(False)"
	def lisp(self): return "#t" if self.val == True else "$f"
	def compile(self): return "T" if self.val == True else "F"
	def eval(self, env={}): return self.val
	def beta(self, var, val): return self

class S: # string
	def __init__(self, val): self.val = val
	def __repr__(self): return f"S(\"{self.val}\")"
	def lisp(self): return f"\"{self.val}\""
	def compile(self): return 'S' + "".join(chr(alpha.index(c)+33) for c in self.val)
	def eval(self, env={}): return self.val
	def beta(self, var, val): return self

class N: # number
	def __init__(self, val): self.val = val
	def __repr__(self): return f"N({self.val})"
	def lisp(self): return f"{self.val}"
	def compile(self): return f"I{int_to_base94(self.val)}"
	def eval(self, env={}): return self.val
	def beta(self, var, val): return self

class U: # unary op
	def __init__(self, op, rhs=None): self.op, self.rhs = op, rhs
	def __repr__(self): return f"U('{self.op}',{self.rhs.lisp()})"
	def lisp(self):
		if self.op == '-': return f"(- {self.rhs.lisp()})"
		elif self.op == '!': return f"(not {self.rhs.lisp()})"
		elif self.op == '#': return f"(number->string {self.rhs.lisp()})"
		elif self.op == '$': return f"(string->number {self.rhs.lisp()})"
		else: raise Exception(f"Unknown unary op {self.op}")
	def compile(self): return f"U{self.op} {self.rhs.compile()}"
	def eval(self, env={}):
		if self.op == '-': return -self.rhs.eval(env)
		elif self.op == '!': return not self.rhs.eval(env)
		elif self.op == '#':
			num = 0
			for char in self.rhs.eval(env):
				num = num * 94 + (alpha.index(char))
			return num
		elif self.op == '$':
			num = self.rhs.eval(env)
			if num == 0: return '!'
			if num < 0: raise Exception("$ for negative numbers not supported")
			chars = []
			while num:
				chars.append(alpha[num % 94])
				num //= 94
			chars.reverse()
			return ''.join(chars)
		else: raise Exception(f"Unknown unary op {self.op}")
	def beta(self, var, val): return U(self.op, self.rhs.beta(var,val))

class B: # binary op
	def __init__(self, op, lhs=None, rhs=None): self.op, self.lhs, self.rhs = op, lhs, rhs
	def __repr__(self):
		return f"B('{self.op}',{self.lhs},{self.rhs})"
		if self.op == '$': return f"({self.lhs} {self.rhs})"
	def lisp(self):
		if self.op == '$': return f"(apply {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '+': return f"(+ {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '-': return f"(- {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '*': return f"(* {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '/': return f"(/ {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '<': return f"(< {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '>': return f"(> {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '=': return f"(= {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '|': return f"(| {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '&': return f"(& {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '.': return f"(. {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == 'T': return f"(take {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == 'D': return f"(drop {self.lhs.lisp()} {self.rhs.lisp()})"
		elif self.op == '%': return f"(modulo {self.lhs.lisp()} {self.rhs.lisp()})"
		else: raise Exception(f"Unknown binary op {self.op}")
	def compile(self): return f"B{self.op} {self.lhs.compile()} {self.rhs.compile()}"
	def eval(self, env={}):
		if self.op == '+': return self.lhs.eval(env) + self.rhs.eval(env)
		elif self.op == '-': return self.lhs.eval(env) - self.rhs.eval(env)
		elif self.op == '*': return self.lhs.eval(env) * self.rhs.eval(env)
		elif self.op == '/': return int(self.lhs.eval(env) / self.rhs.eval(env))
		elif self.op == '<': return self.lhs.eval(env) < self.rhs.eval(env)
		elif self.op == '>': return self.lhs.eval(env) > self.rhs.eval(env)
		elif self.op == '=': return self.lhs.eval(env) == self.rhs.eval(env)
		elif self.op == '|': return self.lhs.eval(env) or self.rhs.eval(env)
		elif self.op == '&': return self.lhs.eval(env) and self.rhs.eval(env)
		elif self.op == '.': return self.lhs.eval(env) + self.rhs.eval(env)
		elif self.op == 'T': return self.rhs.eval(env)[:self.lhs.eval(env)]
		elif self.op == 'D': return self.rhs.eval(env)[self.lhs.eval(env):]
		elif self.op == '%':
			a, b = self.lhs.eval(env), self.rhs.eval(env)
			res = a % b
			return res if not res else res-b if a<0 else res
		elif self.op == '$':
			lhs = self.lhs.eval(env)
			if not isinstance(lhs, F): raise Exception(f"Cannot apply({lhs}, {self.rhs}, {env}); was {self.lhs}")
			return lhs.body.beta(lhs.var, self.rhs).eval(env)
		else: raise Exception(f"Unknown binary op {self.op}")
	def beta(self, var, val): return B(self.op, self.lhs.beta(var,val), self.rhs.beta(var,val))

class F: # lambda
	def __init__(self, var, body=None): self.var, self.body = var, body
	def __repr__(self): return f"F({self.var},{self.body})"
	def lisp(self): return f"(lambda (v{self.var}) {self.body.lisp()})"
	def eval(self, env={}): return self
	# in case of shadowing, stop!
	def beta(self, var, val): return self if var == self.var else F(self.var, self.body.beta(var,val))
	def compile(self):
		if isinstance(self.var, str): return f"L{self.var} {self.body.compile()}"
		else: return f"L{int_to_base94(self.var)} {self.body.compile()}"

class V: # variable
	def __init__(self, var): self.var = var
	def __repr__(self): return f"V({self.var})"
	def lisp(self): return f"{self.var}"
	def compile(self):
		if isinstance(self.var, str): return f"v{self.var}"
		else: return f"v{int_to_base94(self.var)}"
	def eval(self, env={}):
		assert self.var in env
		return env[self.var].eval(env)
	def beta(self, var, val): return val if var == self.var else self

class If:
	def __init__(self, cond=None, truth=None, false=None): self.cond, self.truth, self.false = cond, truth, false
	def __repr__(self): return f"If({self.cond},{self.truth},{self.false})"
	def lisp(self): return f"(if {self.cond.lisp()} {self.truth.lisp()} {self.false.lisp()})"
	def compile(self): return f"? {self.cond.compile()} {self.truth.compile()} {self.false.compile()}"
	def eval(self, env={}): return self.truth.eval(env) if self.cond.eval(env) else self.false.eval(env)
	def beta(self, var, val): return If(self.cond.beta(var,val),self.truth.beta(var,val),self.false.beta(var,val))

class Parser:
	def __init__(self, s):
		self.tokens = [self.tokenize(t) for t in s.split()]
		self.position = 0
		self.lambdas = 0

	def tokenize(self, s):
		if s[0] == 'T':
			return Bool(True)
		elif s[0] == 'F':
			return Bool(False)
		elif s[0] == 'S':
			return S("".join(alpha[ord(c)-33] for c in s[1:]))
		elif s[0] == 'I':
			return N(base94_to_int(s[1:]))
		elif s[0] == 'B':
			return B(s[1])
		elif s[0] == 'U':
			return U(s[1])
		elif s[0] == '?':
			return If()
		elif s[0] == 'L':
			return F(base94_to_int(s[1:]))
		elif s[0] == 'v':
			return V(base94_to_int(s[1:]))
		else:
			raise Exception(f"Unknown instruction {s[0]}")

	def advance(self): self.position += 1

	def parse(self, vars={}):
		token = self.tokens[self.position]

		if isinstance(token, (Bool, N, S)):
			self.advance()
			return token

		if isinstance(token, V):
			self.advance()
			if token.var in vars: token.var = vars[token.var]
			return token

		if isinstance(token, B):
			self.advance()
			token.lhs = self.parse(vars)
			token.rhs = self.parse(vars)
			return token

		if isinstance(token, U):
			self.advance()
			token.rhs = self.parse(vars)
			return token

		if isinstance(token, If):
			self.advance()
			token.cond = self.parse(vars)
			token.truth = self.parse(vars)
			token.false = self.parse(vars)
			return token

		if isinstance(token, F):
			self.advance()
			self.lambdas += 1
			token.var, token.body = self.lambdas, self.parse(vars | {token.var: self.lambdas})
			# token.var, token.body = self.lambdas, self.parse(vars | {token.var: self.lambdas})
			return token

		raise ValueError(f"Unexpected token: {token}")

## helpers

def parse(s): return Parser(s).parse()
def eval(s): return parse(s).eval()
def compile(s): return S(s).compile()

def A(x,y): return B('$',x,y)

Next = A(V('r'), B('-',V('i'),N(1)))
def times(n,base,step):
	"""
	run step n times, where base is base case
	n - number
	base - ICFP expr for base case
	step - ICFP expr for step code, MUST call Next for next step
	special variables:
		- f and x are Y combinator vars λf.(λx.f(xx))(λx.f(xx))
		- i is a loop counter, from n to 1
		- r is recursive function call
	"""
	Y = F('f', A(
		F('x', A(V('f'), A(V('x'), V('x')))),
		F('x', A(V('f'), A(V('x'), V('x'))))))
	return A(A(Y,F('r',F('i',If(B('=',V('i'),N(0)),base,step)))),N(n))

def echo(cmd, asint=False):
	"""
	eval expression using echo service
	"""
	if isinstance(cmd, str): cmd = RawICFP(s)
	if asint: cmd = U("$", cmd)
	return communicate(B(".", S("echo "), cmd)).val

def tests():
	assert eval("T") == True
	assert eval("F") == False

	assert eval("I/6") == 1337
	assert eval("SB%,,/}Q/2,$_") == "Hello World!"

	assert eval("U- I$") == -3, "U-"
	assert eval("U! T") == False, "U!"
	assert eval("U# S4%34") == 15818151, "U#"
	assert eval("U$ I4%34") == "test", "U$"

	assert eval("B+ I# I$") == 5, "B+"
	assert eval("B- I$ I#") == 1, "B-"
	assert eval("B* I$ I#") == 6, "B*"
	assert eval("B/ U- I( I#") == -3, "B/"
	assert B('/', N(7),N(4)).eval() == 1, "B+/+"
	assert B('/', U('-',N(7)),N(4)).eval() == -1, "B-/+"
	assert B('/', N(7),U('-',N(4))).eval() == -1, "B+/-"
	assert B('/', U('-',N(7)),U('-',N(4))).eval() == 1, "B-/-"
	assert eval("B% U- I( I#") == -1, "B%"
	assert eval("B< I$ I#") == False, "B<"
	assert eval("B> I$ I#") == True, "B>"
	assert eval("B= I$ I#") == False, "B="
	assert eval("B| T F") == True, "B|"
	assert eval("B& T F") == False, "B&"
	assert eval("B. S4% S34") == "test", "B."
	assert eval("BT I$ S4%34") == "tes", "BT"
	assert eval("BD I$ S4%34") == "t", "BD"

	assert eval("? B> I# I$ S9%3 S./") == "no", "if"

	assert eval("B$ B$ L# L$ v# B. SB%,,/ S}Q/2,$_ IK") == "Hello World!"

	assert eval("B$ L# B$ L\" B+ v\" v\" B* I$ I# v8") == 12
	assert eval("B$ L\" B+ v\" v\" B* I$ I#") == 12
	assert eval("B+ B* I$ I# B* I$ I#") == 12
	assert eval("B+ I' B* I$ I#") == 12
	assert eval("B+ I' I'") == 12
	assert eval("I-") == 12

	assert eval("B$ B$ La B$ Lb B$ va B$ vb vb Lb B$ va B$ vb vb La Lb ? B= vb I! I\" B$ Lc B+ B$ va vc B$ va vc B- vb I\" I%") == 16

tests()

## lambdaman
class Lambdaman:
	def __init__(self, grid):
		self.grid = grid.splitlines()

	def find_lambda_man_and_pills(self):
		pills = []
		start = None
		for r, row in enumerate(self.grid):
			for c, char in enumerate(row):
				if char == 'L':
					start = (r, c)
				elif char == '.':
					pills.append((r, c))
		return start, pills

	def bfs(self, start, target):
		rows, cols = len(self.grid), len(self.grid[0])
		directions = {'U': (-1, 0), 'R': (0, 1), 'D': (1, 0), 'L': (0, -1)}
		reverse_directions = {(-1, 0): 'U', (0, 1): 'R', (1, 0): 'D', (0, -1): 'L'}

		queue = deque([(start, [])])
		visited = set()
		visited.add(start)

		while queue:
			(current, path) = queue.popleft()
			if current == target: return path

			for direction, (dr, dc) in directions.items():
				next_pos = (current[0] + dr, current[1] + dc)
				if 0 <= next_pos[0] < rows and 0 <= next_pos[1] < cols:
					if self.grid[next_pos[0]][next_pos[1]] != '#' and next_pos not in visited:
						visited.add(next_pos)
						queue.append((next_pos, path + [direction]))
		return []

	def solve(self):
		start, pills = self.find_lambda_man_and_pills()
		current_pos = start
		total_path = []

		while pills:
			shortest_path = None
			shortest_distance = float('inf')
			closest_pill = None

			for pill in pills:
				path_to_pill = self.bfs(current_pos, pill)
				if path_to_pill and len(path_to_pill) < shortest_distance:
					shortest_distance = len(path_to_pill)
					shortest_path = path_to_pill
					closest_pill = pill

			if shortest_path:
				total_path.extend(shortest_path)
				current_pos = closest_pill
				pills.remove(closest_pill)

		return ''.join(total_path)

for i in range(1,10):
	print(f"solving lambdaman {i}")
	puzzle = communicate(f"get lambdaman{i}").eval()
	print(puzzle)
	if i==9:
		print(communicate(times(50*50,S("solve lambdaman9 "),B('.',Next,
			If(B('=',N(0),B('%',V('i'),N(50))),
				S('D'),
				If(B('=',N(0),B('%',B('/',V('i'),N(50)),N(2))),
					S('R'),
					S('L')
				)
			)
		))))
		continue
	elif i==8: path = ''.join('DLUR'[(floor(sqrt(2*i-1))-1) % 4] for i in range(1,4900))
	else: path = Lambdaman(puzzle).solve()
	print(path)
	print(communicate(f"solve lambdaman{i} {path}").eval())
