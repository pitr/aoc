run ← {
    ⍺ ← 0
    0∧.=¯1↓⍵: ⍺
    floor ← ⊃⍸0<⍵
    (⍺ + ¯3+2×⍵[floor]) ∇ (0,+/)@(floor+⍳2)⊢⍵
}

⎕← run    8 2 0 0
⎕← run (4+8)2 0 0