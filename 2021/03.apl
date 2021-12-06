n ← ↓⍉↑ ('1'=⊢) ⊃⎕nget'03.txt'1

mf ← +/≥≢-+/ ⋄ lf ← +/<≢-+/     ⍝ most/least frequent
r ← {1=≢⍵: ⍵ ⋄ ⍵∩⍸⍺=⍺⍺ ⍺[⍵]}    ⍝ reducer
ix ← ⊂⍳≢⊃n

×/ 2⊥ ↑ (mf,lf)¨ n                      ⍝ part 1
×/ 2⊥¨ {⍵⌷¨n}¨ (mf r/ , lf r/) ⌽ix,n    ⍝ part 2
