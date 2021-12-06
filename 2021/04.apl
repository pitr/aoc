f ← ⍎¨¨(''∘≢¨⊆⊢)⊃⎕NGET'in/04.txt' 1
d b ← (⊃⊃f)(↑↑ 1↓f)             ⍝ dice, board

win ← ⌊/ (⌈/[1] ⌊ ⌈/) d⍳b       ⍝ index of winning dice per card
score ← { d[win[⍵]] × +/, ⍵⌷b×~b∊ (1+win[⍵])↑d }

score win⍳ ⌊/ win       ⍝ part 1: score of first card to win
score win⍳ ⌈/ win       ⍝ part 2: score of last card to win