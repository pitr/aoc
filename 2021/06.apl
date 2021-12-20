n ← +/ (⍳9) ∘.= ⍎⊃⊃⎕NGET'in/06.txt' 1

fish ← { x ← 1⌽⍵ ⋄ x[6] +← x[8] ⋄ x }

+/ fish⍣80 ⊢ n
+/ fish⍣256 ⊢ n

⍝lternative solution
fish ← { n[9|⍵+7] +← n[9|⍵] }
fish¨80↑⍳256 ⋄ +/n
fish¨80↓⍳256 ⋄ +/n
