m ← ↑'.>v'∘⍳¨⊃⎕NGET'in/25.txt'1

east  ←  {i←⍸(1=⍵)∧0=1⌽⍵ ⋄ 1@((≢⍵)|i+1)⊢0@i⊢⍵}⍤1
south ← ⍉{i←⍸(2=⍵)∧0=1⌽⍵ ⋄ 2@((≢⍵)|i+1)⊢0@i⊢⍵}⍤1⍤⍉
step ← south∘east

{⍵ ≡ next←step⍵: 1 ⋄ 1+∇next} m


