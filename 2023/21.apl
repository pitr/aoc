M ← '#.S'⍳↑⊃⎕NGET'in/21.txt'1
start ← ,1 0J1+.×⊃⍸M=2
M ← 1 0J1+.×⍉↑⍸×M
result ← ⍬
a b c ← {
    ⍺←1
    next/⍨← M∊⍨1 0J1+.×131|9 11∘.○next←∪,1 ¯1 0J1 0J¯1∘.+⍵
    64=⍺: (⍺+1) ∇ next ⊣ ⎕←≢next
    65=131|⍺: (⍺+1) ∇ next ⊣ result,←≢next
    ⍺>3×131: result
    (⍺+1) ∇ next
} start
n ← ⌊26501365 ÷ 131
⎕← a+n×(b-a)+(n-1)×(a+c-2×b)÷2
