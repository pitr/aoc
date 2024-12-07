map ← '.#^'⍳↑⊃⎕NGET'in/06.txt'1
dir ← (¯1 0)(0 1)(1 0)(0 ¯1)
saw ← 0⍴⍨4,⍴map ⋄ start ← ⊃⍸2=map
walk ← { ⍺←0
    saw[⊂⍺,⍵]: 0
    saw[⊂⍺,⍵] ← 1
    nxt ← ⍵+⍺⊃dir
    ∨/∊(nxt=¯1)(nxt=⍴⍺⍺): +/,∨⌿saw
    1=⍺⍺[⊂nxt]: (4|1+⍺)∇⍵
    ⍺∇nxt
}
⎕← map walk start
⍝ part 2 takes ~30s
⎕← +/0={saw×←0 ⋄ (1@(⊂⍵)⊢map) walk start}¨⍸∨⌿saw
