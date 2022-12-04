d ← ↑{3~⍨23|⎕A⍳⍵}¨ ⊃⎕NGET'in/02.txt'1

⎕← (1+⊢/d) +.+ 3×3|1--/d
⎕← (3×⊢/d) +.+ 1+3|2++/d

⍝n alternative, using precomputed values
⎕← +/4 8 3 1 5 9 7 2 6[3⊥⍉d]
⎕← +/3 4 8 1 5 9 2 6 7[3⊥⍉d]
