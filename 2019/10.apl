n ← 1 0J1+.×⍨↑⍸m←'#'=↑⊃⎕NGET'in/10.txt'1

⎕← ⌈/a←{≢∪12○⍵~0}⍤1⊢∘.-⍨n
⎕← 100⊥11 9○199⊃∪∊⍉↑{⍵[⍒⍵;1]}{(12○⍵-q){⍺⍵}⌸⍵}n[⍋10○n-q←n[⊃⍒a]]
