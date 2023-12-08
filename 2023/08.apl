D ← 'LR'⍳⊃f←⊃⎕NGET'in/08.txt'1
G ← 1↓¨(N←⊃¨n)∘⍳¨n←{(⍵∊⎕A,⎕D)⊆⍵}¨2↓f

walk ← {⍺←0 ⋄ ⍵∊z:⍺ ⋄ (⍺+1)∇D[(≢D)|⍺]⊃⍵⊃G}

⎕←   walk ⊃a z ← N⍳'AAA' 'ZZZ'
⎕← ∧/walk¨⊃a z ← ⍸¨↓'AZ'∘.=2⊃¨N
