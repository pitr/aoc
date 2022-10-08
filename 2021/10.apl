f ← ⊃⎕NGET'in/10.txt'1

open  ← '([{<'
close ← ')]}>'
pairs ← open,¨close

f ← {⍵/⍨ s⍱¯1⌽ s← +⌿↑ pairs ⍷¨ ⊂⍵}⍣≡¨ f     ⍝ simplify

+/3 57 1197 25137 0[i←{close⍳⊃⍵~open}¨f]
(⊢⌷⍨⍋⌷⍨(⌊.5×≢)) {(⊣+5×⊢)/1+open⍳⍵}¨ f/⍨i=4
