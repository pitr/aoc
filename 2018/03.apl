f ← {↓+⍀2 2⍴ ⍎¨ 1↓(⍵∊⎕D)⊆⍵}¨⊃⎕NGET'in/03.txt'1

coords ← {,⊃{(⊂⍺)+⍳⍵-⍺}/⍵}
1 +.< {≢⍵}⌸⊃,/ coords¨f

intersect ← { ((⊃⌈/⍤⊣) ∧.< (⊃⌊/⍤⊢))/ ↓⍉↑⍺⍵ }
1+1⍳⍨+/∘.intersect⍨f
