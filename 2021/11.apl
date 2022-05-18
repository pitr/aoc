f ← ↑⍎¨¨⊃⎕NGET'in/11.txt'1

step ← {0@(9∘<) ⍵+ ⍵{1+{+/,⍵}⌺3 3⊢9<⍺+⍵}⍣≡1}

⍝ pow :: A (A ∇ S -> A) ∇∇ (A ∇ S -> B) S => A where A=accumulator S=state B=bool
pow ← {⍺ ⍵⍵ ⍵: ⍺ ⋄ (⍺∘⍺⍺ ∇ ⊢) step ⍵}

+/ ⍬ {⍺,+/0=,⍵} pow {100=≢⍺} f
   0 {⍺+1}      pow {0∧.=,⍵} f
