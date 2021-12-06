f ← ⍎¨¨(''∘≢¨⊆⊢)⊃⎕nget'04.txt' 1
d b ← (⊃⊃f)(↑↑ 1↓f)             ⍝ dice, board

wp ← d⍳b                    ⍝ turns to win per position
wc ← ⌊/ (⌈/[1] ⌊ ⌈/) wp     ⍝ turns to win per card

play ← {
    ⍺ ← (≢b)⍴0
    marked ← b∊⍵↑d
    won ← ∨/ (∧/[1] ∨ ∧/) marked
    ⍺⍺/won : d[⍵-1] × +/, (won-⍺)⌿ b×~marked
    won ⍺⍺ ∇∇ ⍵+1
}

∨ play 1        ⍝ part 1
∧ play 1        ⍝ part 2
