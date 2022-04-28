f ← (↑⍎¨)¨(×∘≢¨⊆⊢)⊃⎕NGET'in/04.txt'1
deck board ← (∊⊃f) (1↓f)

wins ← {⌊/ (⌈⌿ , ⌈/) deck⍳⍵}¨board      ⍝ index of winning dice per card
score ← { deck[wins[⍵]] × (⍵⊃board) {+/∊⍺×~⍺∊⍵} (1+wins[⍵])↑deck }

score wins⍳ ⌊/ wins     ⍝ part 1: score of first card to win
score wins⍳ ⌈/ wins     ⍝ part 2: score of last card to win
