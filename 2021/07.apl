n ← ⍎⊃⊃⎕NGET'in/07.txt'1

dx ← | n ∘.- ⍳⌈/n

⌊/ +⌿ dx
⌊/ +⌿ (dx × dx+1)÷2