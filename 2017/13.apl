p d ← ↓⍉↑(⍎¨∊∘⎕D⊆⊢)¨⊃⎕NGET'in/13.txt'1

⎕← +/p×d×0=(mod←2×d-1)|p
step ← ⌊/mod
⎕← {0∊mod|p+⍵: ∇⍵+step ⋄ ⍵} 0
