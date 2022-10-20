n ← ↓⍉↑ '1'= ⊃⎕NGET'in/03.txt'1

mf ← +/≥≢-+/ ⋄ lf ← +/<≢-+/     ⍝ most/least frequent
r ← {1=+/⍵:⍵ ⋄ ⍵∧⍺=⍺⍺ ⍵/⍺}      ⍝ reducer, computes mask using ⍺⍺

×/ 2⊥ ↑ (mf,lf)¨ n                      ⍝ part 1
×/ 2⊥ n∘.{⊃⍵/⍺} (mf r/ , lf r/) ↓⊖1⍪↑n  ⍝ part 2
