'bsearch'⎕CY'dfns'

n ← ⍎¨f←⊃⎕NGET'in/18.txt'1
D ← 71 ⋄ N ← 1024 ⍝ ⋄ D ← 7 ⋄ N ← 12
G ← ,{⊂¯1~⍨(,⍵-1)/⍨9⍴⍳2}⌺3 3⊢0@(N↑n)⊢D D⍴1+⍳D×D
skip ← D 1+.×⍉↑N↓n

bfs ← {0{
    ⍺≡⍬: 0 ⋄ ¯1≠⊢/⍵: ⊢/⍵
    next ← (⊃∪/G[⍺])∩⍸⍵=¯1
    next ∇ (1+⌈/⍵)@next⊢⍵
}¯2@⍵⊢¯1+0=⍳≢G}

⎕← bfs ⍬
⎕← f⊃⍨¯1+N+{0=bfs ⍵↑skip} bsearch 0,≢skip
