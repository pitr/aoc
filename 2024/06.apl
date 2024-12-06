map ← '.#^'⍳↑⊃⎕NGET'in/06.txt'1
dir ← (¯1 0)(0 1)(1 0)(0 ¯1)
saw ← 0⍴⍨4,⍴map ⋄ start ← ⊃⍸2=map
walk ← { ⍺←0
    saw[⊂⍺,⍵]: 0
    saw[⊂⍺,⍵] ← 1
    3:: +/,∨⌿saw
    1=⍺⍺[⊂⍵+⍺⊃dir]: ⍵∇⍨4|1+⍺
    ⍺∇⍵+⍺⊃dir
}
⎕← map walk start
⍝ part 2 takes ~35s
⎕← +/0={saw×←0 ⋄ (1@(⊂⍵)⊢map) walk start}¨⍸∨⌿saw
