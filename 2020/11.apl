m ← '.'≠↑⊃⎕NGET'in/11.txt'1

⎕← +/, {m×(1+4×⍵)>{+/,⍵}⌺3 3⊢⍵}⍣≡2=m

C ← 0⍪{↑(1↓¨↓⍵)[⍋⍵]}⊃,⌸/↓⍉{⍵⍪⌽⍵}↑⊃,/⊃,/(+/i)(-/i)(⊣/i)(⊢/i){⊂2,/⍵}⌸¨⊂1+⍳≢i←↑⍸m
⎕← +/{(1+4×⍵)>1↓+/(0,⍵)[C]}⍣≡0/⍨≢i
