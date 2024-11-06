'bsearch'⎕CY'dfns'

n r ← ↓⍉↑{(⍎¨'\d+'⎕S'&'⊢⍵)('[A-Z]+'⎕S'&'⊢⍵)}¨⊃⎕NGET'in/14.txt'1
e ← (⊂'ORE'),⊃∘⌽¨r
N ← 9e99,⊢/¨n
M ← 0⍪↑n{ (¯1↓⍺)@(e⍳¯1↓⍵)⊣0×N }¨r
ore ← {⊃{ (c+.×M)+⍵-N×c←⌈⍵÷N }⍣≡ ⍵×e∊⊂'FUEL'}
⎕← ore 1
⎕← ¯1+{1e12≤ore⍵} bsearch 1,1e12
