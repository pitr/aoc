n ← ↓⍉↑ ('1'=⊢) ⊃⎕NGET'in/03.txt'1

mf ← +/≥≢-+/ ⋄ lf ← +/<≢-+/     ⍝ most/least frequent
r ← {1=≢⍵: ⍵ ⋄ ⍵∩⍸⍺=⍺⍺ ⍺[⍵]}    ⍝ reducer, computes subset of ix using function
ix ← ⊂⍳≢⊃n

×/ 2⊥ ↑ (mf,lf)¨ n                      ⍝ part 1
×/ 2⊥¨ {⍵⌷¨n}¨ (mf r/ , lf r/) ⌽ix,n    ⍝ part 2
