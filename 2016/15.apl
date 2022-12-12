size pos ← ↓⍉↑{(⍎¨(⍵∊⎕D)⊆⍵)[1 3]}¨⊃⎕NGET'in/15.txt'1
pos ← size|1+pos+⍳≢pos

⎕← { ⍵+~0∧.=size|⍵+pos }⍣≡0

size ,← 11 ⋄ pos ,← 11|1+≢pos
⎕← { ⍵+~0∧.=size|⍵+pos }⍣≡0
