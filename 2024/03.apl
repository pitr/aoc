n ← ∊⊃⎕NGET'in/03.txt'1

r ← 'mul\((\d+),(\d+)\)'
⎕← +/r ⎕S {×/⍵.Match(⍎¨∊⊆⊣)⎕D}n

r ← '(mul\((\d+),(\d+)\)|do\(\)|don''t\(\))'
e ← 1
⎕← +/r ⎕S {
    c←⍵.Match[2]
    '('=c: 0⊣e∘←1
    'n'=c: 0⊣e∘←0
    e××/⍵.Match(⍎¨∊⊆⊣)⎕D
}n
