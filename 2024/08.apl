m ← ↑⊃⎕NGET'in/08.txt'1
⎕← ≢⊃∪/{(⍸m≠⍵)∩   ,∘.{  ⍺ +          ⍺-⍵}⍨⍸m=⍵}¨(∪∊m)~'.'
⎕← ≢⊃∪/{(⍸m≠0)∩⊃∪/,∘.{(⊂⍺)+¨(⍳⌈/⍴m)×⊂⍺-⍵}⍨⍸m=⍵}¨(∪∊m)~'.'
