f ← ⊃⎕NGET'in/10.txt' 1

open   ← '([{<'
close  ← ')]}>'
pairs ← ↓open,[.5]close

r ← {((~⊢∨¯1∘⌽)⍺⍷⍵) / ⍵}        ⍝ remove substring
simp ← {⊃ (r/pairs,⊢)⍣≡ ⊂⍵}¨f  ⍝ simplify each line

+/3 57 1197 25137 0[i←close⍳(⊃~∘open)¨simp]
{⍵[⍋⍵][⌊0.5×≢⍵]} {(⊣+5×⊢)/1+open⍳⍵}¨ (i=4)/simp
