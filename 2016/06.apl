lines ← {⌽⍺,≢⍵}⌸¨↓⍉↑⊃⎕NGET'in/06.txt'1
⎕← {⍵[⊃⍒⍵;1]}¨lines
⎕← {⍵[⊃⍋⍵;1]}¨lines
