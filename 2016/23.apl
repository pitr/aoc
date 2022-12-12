⍝ based on disassembled code
X ← ×/ {⍎(⍵∊⎕D)/⍵}¨ (⊂19 20)⌷⊃⎕NGET'in/23.txt'1
⎕← {X + ×/⍵-⍳⍵-1}¨ 7 12
