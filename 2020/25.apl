d c ← ⍎¨⊃⎕NGET'in/25.txt'1

loop ← 0 {⍵=d: ⍺ ⋄ (⍺+1) ∇ 20201227|7×⍵} 1
⎕← (20201227|c∘×)⍣loop⊢1
