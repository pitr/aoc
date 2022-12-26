'pmat'⎕CY'dfns'

src _ dst _ len ← ↓⍉↑' '(≠⊆⊢)¨⊃⎕NGET'in/09.txt'1
places ← ∪src,dst
costs ← (⍉⌈⊢) (⍎¨len) @ (src(,¨⍥(places∘⍳))dst)⊢ (2/≢places)⍴0

⎕← (⌊/,⌈/) {+/2{costs[⍺;⍵]}/⍵}¨↓pmat ≢places
