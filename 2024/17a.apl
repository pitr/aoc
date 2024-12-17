a ← ⊃n ← ⍎¨⎕D(∊⍨⊆⊢)∊⊃⎕NGET'in/17.txt'1
n ← 3↓n
xor ← 2⊥(≠/2(⊥⍣¯1),)
run ← ⍬ { ⍝ :: pc (out ∇∇) 0 1 2 3 A B C
    ⍺ ← 0
    ⍺≥≢n: ⍺⍺
    op ← ⍺⊃n
    combo ← ⍵[n[⍺+1]]
    op=0: (⍺+2)∇(⌊⍵[4]÷2*combo)@4⊢⍵
    op=1: (⍺+2)∇(⍵[5] xor n[⍺+1])@5⊢⍵
    op=2: (⍺+2)∇(8|combo)@5⊢⍵
    op=3: ⍵∇⍨(2 0+⍺,n[⍺+1])[⍵[4]≠0]
    op=4: (⍺+2)∇(⍵[5] xor ⍵[6])@5⊢⍵
    op=5: ⍵((⍺⍺,8|combo)∇∇)⍨⍺+2
    op=6: (⍺+2)∇(⌊⍵[4]÷2*combo)@5⊢⍵
    op=7: (⍺+2)∇(⌊⍵[4]÷2*combo)@6⊢⍵
    'unknown op'op
}
native ← { ⍝ :: ∇A
    ⍺ ← ⍬
    0=⍵: ⍺
    b ← n[3] xor 8|⍵
    (⍺,8|n[9] xor b xor ⌊⍵÷2*b) ∇ ⌊⍵÷2*3
}
⎕← run 0 1 2 3 a 0 0
⎕← native a

⍝ part 2 uses native dfn and z3, see 17b.py
