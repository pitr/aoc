pos xy ← (⊢⊆⍨0≠≢¨)⊃⎕NGET'in/13.txt'1
board ← {1@⍵⊢(1+↑⌈/⍵)⍴0}⍎¨pos
fold ← {(⌊.5×≢⍵) ↑ ⍵∨⊖⍵}
foldxy ← {fold⍣⍵ ⍉ fold⍣⍺⊢board}

+/,⊃foldxy/'xy'∊⊃xy
' █'[⊃foldxy/+/'xy'∘.∊xy]
