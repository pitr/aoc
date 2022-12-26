'trav'⎕CY'dfns'

s ← ⍎¨⊃⎕NGET'in/17.txt'1
io ← ⍳≢s
lim ← 150

⍝ accumulate number of containers
r ← ⍬ {⍺,(lim=+/s[⍵])↑⊂≢⍵} trav {(⊂⍵),¨⍸io>⌈/⍵} ⍬
⎕← ≢r
⎕← 1⊃{⍵[⊃⍋⍵;]}{⍺,≢⍵}⌸r
