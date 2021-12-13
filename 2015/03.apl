l r d u ← ⍪¨↓'<>v^'∘.∊⊃⎕NGET'in/03.txt'

walk ← {↓+⍀⍺×,⍨⍪(≢⍺)⍴⍵}

xy ← (r-l),(d-u)
≢∪ xy walk 1
≢∪(xy walk 1 0),(xy walk 0 1)