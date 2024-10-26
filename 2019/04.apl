'trav'⎕CY'dfns'

min max ← ⍎¨'-'(≠⊆⊢)⊃⊃⎕NGET'in/04.txt'1

next ← { (⊂⍵),¨m+⍳10-m←(6=≢⍵)↓1⌈⌈/⍵ }
acc ← { ⍺+(adj ⍵)∧(max≥n)∧min≤n←10⊥⍵ }

adj ← ⊢≢∪
⎕← 0 acc trav next ⍬

adj ← 2∊{≢⍵}⌸
⎕← 0 acc trav next ⍬
