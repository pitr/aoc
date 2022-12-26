step ← {∊((⍕≢),⊃)¨(1,2≠/⍵)⊂⍵}
c ← ⊃⊃⎕NGET'in/10.txt'1
⎕← ≢c←step⍣40⊢c
⎕← ≢  step⍣10⊢c
