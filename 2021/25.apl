m ← 1-↑'>.v'∘⍳¨⊃⎕NGET'in/25.txt'1

east  ← ⊢{(⍺+¯1⌽⍵)-⍵}     0∘<∧0=1∘⌽
south ← ⊢{(⍺+¯1⊖⍵)-⍵} ¯1× 0∘>∧0=1∘⊖

{ ⍵≡next ← south east ⍵: 1 ⋄ 1+∇next } m
