f ← ⎕UCS ⊃⊃⎕NGET'in/05.txt'1

react ← ≢{-⍵/⍨d∧¯1⌽d←32≠2-/⍵,0}⍣2⍣≡

react f
⌊/ {react f~⍵+0 32}¨⎕UCS ⎕A
