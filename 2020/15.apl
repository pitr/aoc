N←⍎⊃⊃⎕NGET'in/15.txt'1

run ← {
    last ← (⍳≢⍵)@⍵⊢⍺/⍺
    ⍝ turn ∇ last → value, run for each turn
    ⍝ last[n] is the last turn n was called
    {0⌈⍺-(last[⍵]←⍺)⊢last[⍵]}/⌽0,(≢⍵)↓⍳⍺-1
}
⎕← 2020 run N
⎕← 3e7 run N  ⍝ slow (20s) but works
