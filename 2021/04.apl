f ← (↑⍎¨)¨(×∘≢¨⊆⊢)⊃⎕NGET'in/04.txt'1
deck boards ← (∊⊃f) (1↓f)

moves ← {⌊/ (⌈⌿ , ⌈/) deck⍳⍵}¨boards    ⍝ index of winning dice per card
scores ← boards {deck[⍵] × +/∊⍺×~⍺∊(1+⍵)↑deck}¨ moves   ⍝ scores per card

scores[moves⍳ ⌊/moves]  ⍝ part 1: score of first card to win
scores[moves⍳ ⌈/moves]  ⍝ part 2: score of last card to win
