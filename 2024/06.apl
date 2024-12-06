m ← '.#^'⍳↑⊃⎕NGET'in/06.txt'1
dir ← (¯1 0)(0 1)(1 0)(0 ¯1)
seen ← 0⍴⍨4,⍴m ⋄ start ← 0,⊃⍸2=m
walk ← {
    seen[⊂⍵]: 0
    seen[⊂⍵] ← 1
    3:: +/,∨⌿seen
    1=⍺⍺[dir[⊃⍵]+⊂1↓⍵]: ∇1(4|+)@0⊢⍵
    ∇⍵+0,⊃dir[⊃⍵]
}
⎕← m walk start
⍝ part 2 takes ~40s
⎕← +/0={seen×←0 ⋄ (1@(⊂⍵)⊢m) walk start}¨⍸∨⌿seen
