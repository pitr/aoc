f ← ⎕UCS ⊃⊃⎕NGET'in/05.txt'1

dedup ← {⍵/⍨ ((,∘0)⍱(0∘,)) ⍺=2-/⍵}
run ← {⊃dedup/¯32,32,⊂⍵}⍣≡

≢run f
⌊/ {≢run f~⍵,32+⍵}¨⎕UCS ⎕A
