f ← ⊃⎕NGET'in/01.txt'1
n ← ⍎¨1↓¨f ⋄ s ← 1-2×'L'=⊃¨f
r ← {+/0=100|+\50,⍵}

⎕← r n×s
⎕← r n/s
