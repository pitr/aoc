⍝ based on decompilation
val  ← ×/ {⍎(⍵∊⎕D)/⍵}¨(⊂1 2)⌷ ⊃⎕NGET'in/25.txt'1
want ← 2⊥ (2×⌈4⍟val)⍴1 0

⎕← want - val
