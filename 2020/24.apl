dirs ←  'nw' (,'w') 'sw' 'ne' (,'e') 'se'
pos  ← ¯1j¯1   ¯2  ¯1j1  1j¯1    2   1j1
tiles ← {+/pos[dirs⍳('(n|s)?(e|w)'⎕S'&')⍵]}¨⊃⎕NGET'in/24.txt'1
tiles ← ∊{⊂(2|≢⍵)↑⊂⍺}⌸tiles

⎕← ≢ tiles
⎕← ≢ { t n ← ↓⍉{⍺,≢⍵}⌸∊pos+⊂⍵ ⋄ t/⍨(on∧n∊1 2)∨(~on←t∊⍵)∧n=2 }⍣100⊢tiles
