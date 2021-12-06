n ← +/ (⍳9) ∘.= ⍎⊃⊃⎕NGET'06.txt' 1

fish ← { x ← 1⌽⍵ ⋄ x[6] +← x[8] ⋄ x }

+/ fish⍣80 ⊢ n
+/ fish⍣256 ⊢ n
