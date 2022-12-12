row ← '^'=⊃⊃⎕NGET'in/18.txt'1

step ← (1 3 4 6∊⍨2⊥⊢)⌺3
run ← {
    0=⊃⍵: ⍵[1]
    (step ⍺) ∇ (2↑⍵)+(¯1,+/~⍺)
}

⎕← row run 40
⎕← row run 4e5
