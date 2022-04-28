d ← 'abcdefg'
f ← (d∘∊¨(∊∘d)⊆⊢)¨⊃⎕NGET'in/08.txt'1

⍝ solve ⍵ using expected signature of an outer product of ⍺
solve ← { 10⊥1 7 4 2 5 3 6 0 9 8[⍺[⍋+/+/¨⍺ ∘.∧ ⍺] ⍳ ⍵] }

+/ 2 3 4 7∊⍨ ∊{+/¨¯4↑⍵}¨f
+/ ¯4 (↓ solve ↑)¨f
