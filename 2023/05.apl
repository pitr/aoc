f ← {(×≢¨⍵)⊆⍵}⊃⎕NGET'in/05.txt'1
s ← {⍎¨(⍵∊⎕D)⊆⍵}⊃⊃f
M ← {d s l←↓⍉↑⍎¨1↓⍵ ⋄ (¯1,∊{⍵[⍋s;]}s,⍪s+l)(0,∊(d-s)[⍋s],¨0)}¨1↓f

map ← {⍵+(1⊃⍺)[(⊃⍺)⍸⍵]}                 ⍝ (bounds, distances) ∇ nums → nums
split ← {2,/∪¯1⌽⍺[⊃{⍺+1+⍳⍵-⍺}/⍺⍸⍵],⌽⍵}  ⍝ bounds ∇ range → [range]

⎕← ⌊/∊map/(⌽M),⊂s
⎕← ⌊/∊{⍺map⊃,/⍺[0]split¨⍵}/(⌽M),⊂↓+\(.5×≢s)2⍴s
