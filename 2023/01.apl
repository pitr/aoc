w ← '/'(≠⊆⊢)'zero/one/two/three/four/five/six/seven/eight/nine'

f ← ⊃⎕NGET'in/01.txt'1
cali ← {10⊥∊1 ¯1↑¨⊂⍵~0}

⎕← +/ cali¨d←10|⎕D∘⍳¨f
⎕← +/ cali¨d⌈(⍳10)⌈.×w∘.⍷f
