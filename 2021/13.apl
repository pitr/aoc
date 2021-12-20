pos xy ← (⊢⊆⍨0≠≢¨)⊃⎕NGET'in/13.txt' 1
board ← {1@⍵⊢(1+↑⌈/⍵)⍴0}⍎¨pos
fold ← {f←{(⌊.5×≢⍵)↑⍵∨⊖⍵} ⋄ f⍣⍵⍉f⍣⍺⊢board}

+/,⊃fold/'xy'∊⊃xy
' █'[⊃fold/+/'xy'∘.∊xy]
