x y ← ↓⍉↑⍎¨⊃⎕NGET'in/09.txt'1
xm ym ← ∘.⌊⍨¨x y
xM yM ← ∘.⌈⍨¨x y
⎕← ⌈/,s←(1+yM-ym)×1+xM-xm
um uM ← x(⌊,⍥⊂⌈)1⌽x
vm vM ← y(⌊,⍥⊂⌈)1⌽y
⎕← ⌈/,s×∧/(yM∘.≤vm)∨(ym∘.≥vM)∨(xM∘.≤um)∨(xm∘.≥uM)
