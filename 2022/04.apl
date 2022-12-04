al ah bl bh ← ↓⍉↑(⍎¨⎕D∘(∊⍨⊆⊢))¨⊃⎕NGET'in/04.txt'1

⎕← +/ ((al≤bl)∧(bh≤ah)) ∨ ((bl≤al)∧(ah≤bh))
⎕← +/ (al≤bh)∧(bl≤ah)
