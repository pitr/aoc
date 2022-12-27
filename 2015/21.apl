'cmat'⎕CY'dfns'

hp atk def ← ⎕D(⍎¨∊⍨⊆⊢)∊⊃⎕NGET'in/21.txt'1
costs ← 8 10 25 40 74 13 31 53 75 102 25 50 100 20 40 80
items ← ↑(4 5 6 7 8 0 0 0 0 0 1 2 3 0 0 0)(0 0 0 0 0 1 2 3 4 5 0 0 0 1 2 3)

play ← { (⌈hp÷1⌈⍵[0]-def) ≤ (⌈100÷1⌈atk-⍵[1]) }

opts ← ⊃(,∘.,)/(⍳5)((⊂⍬),5+⍳5)((⊂⍬),10+(⍳6),↓2 cmat 6)
wins ← { play +/items[;⍵] }¨opts

⎕← ⌊/ {+/costs[⍵]}¨opts/⍨wins
⎕← ⌈/ {+/costs[⍵]}¨opts/⍨~wins
