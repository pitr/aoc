pos f ← (⊢⊆⍨0≠≢¨)⊃⎕NGET'in/13.txt' 1
board ← {1@⍵⊢(1+↑⌈/⍵)⍴0}(⌽⍎)¨pos
f ← (0 1)(1 0)[∨/¨'x'=f]
fold ← {w←⍺⍉⍵ ⋄ d←⌊0.5×≢w ⋄ ⍺⍉(d↑w)∨⊖(-d)↑w}

+/,board fold⍨⊃f
' ▮'[⊃fold/f,⊂board]