p ← ⎕D⍸⍤=¨⊂↑⊃⎕NGET'in/10.txt'1
d ← (0 1)(1 0)(0 ¯1)(¯1 0)
t ← 1 { 10=⍺: ⍵ ⋄ (⍺+1)∇(,⍵∘.+d)∩⍺⊃p }¨⊂¨0⊃p

⎕← +/≢∘∪¨t
⎕← +/≢  ¨t
