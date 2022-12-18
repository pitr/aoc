cub ← ⎕D∘(⍎¨∊⍨⊆⊢)¨ ⊃⎕NGET'in/18.txt'1
map ← 1@cub⊢(⊃1+⌈/cub)⍴0
nei ← 1@4 22⊢18⌽27↑9⍴⍳2

window ← { ⍺⍺{⍵[1;1;1] ⍺⍺ nei/∊⍵}⌺3 3 3⊢⍵ }

⎕← all ← +/∊ {⍺×6-+/⍵} window map
⎕← all - +/∊ {⍺×6-+/⍵} window 1= {⍺≠1:⍺ ⋄ ×/×⍵} window⍣≡ 1+map
