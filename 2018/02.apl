f ← ⊃⎕NGET'in/02.txt'1

×/+⌿ ↑{2 3∊1~⍨{≢⍵}⌸⍵}¨f
∩/f[⊃⍸∘.{1=0+.=⍺=⍵}⍨f]
