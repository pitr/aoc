'span'⎕CY'dfns'

no← 0
f ← ' '∘(≠⊆⊢)¨⊃⎕NGET'in/07.txt'1
name wght graph ← ↓⍉↑{(⊃,/⍵[⍳2])(⍎¨r/⍨(≢r)⍴4↑1)((⊃,/)¨r⊆⍨(≢r←4↓⍵)⍴4↑0 1 1)}¨f
graph ← {(name⍳⍵)~≢name}¨graph
gold ← name⍳⊂'shinygold'
upgraph ← ⍸¨↓⍉↑{⍸⍣¯1⊢⍵[⍋⍵]}¨graph

⎕← +/ 1< upgraph span gold
⎕← ¯1+ {⍬≡nxt←⍵⊃graph: 1 ⋄ 1++/(⍵⊃wght)×∇¨nxt} gold
