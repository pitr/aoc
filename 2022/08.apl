grid ← ⍎¨↑⊃⎕NGET'in/08.txt'1

p1 ← {∧/0= ¯1↓   ,⍵}¨⊢≤,\
p2 ← {⊃1+⍸⌽¯1↓1@0,⍵}¨⊢≤,\
dirs ← {⊃⍺⍺/(⍵⍵⍵)(⌽⍵⍵⌽⍵)(⍉⌽⍵⍵⌽t)(⍉⍵⍵t←⍉⍵)}

⎕← +/∊ (⌈ dirs p1) grid
⎕← ⌈/∊ (× dirs p2) grid
