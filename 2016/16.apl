d ← '1'=⊃⊃⎕NGET'in/16.txt'1
grow ← { ⍺≤≢⍵: ⍺↑⍵ ⋄ ⍺ ∇ ⍵,0,~⌽⍵ }
checksum ← {=/(.5×≢⍵)2⍴⍵}⍣{2|≢⍺}

⎕← '01'[checksum 272 grow d]
⎕← '01'[checksum 35651584 grow d]

