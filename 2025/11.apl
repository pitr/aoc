f ← ' :'∘(~⍤∊⍨⊆⊢)¨⊃⎕NGET'in/11.txt'1
n ← ∪⊃,/f
g ← 0×∘.≡⍨n ⋄ {}{g[⊃n⍳⍵;1↓n⍳⍵]←1}¨f
paths ← {⍺⍵⌷+.×⍨⍣≡1@(⊂⍺ ⍺)⊢g}/n⍳∘↓2 3⍴⊢
⎕← paths'youout'
⎕← +⍥{×/paths¨2,/⍵}∘(⌽@1 2)⍨↓4 3⍴'svrfftdacout'
