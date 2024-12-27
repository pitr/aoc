v w ← (×∘≢¨⊆⊢)⊃⎕NGET'in/24.txt'1
join ← ⊃{⍺,',',⍵}/
a op b _ c ← ↓⍉↑' '(≠⊆⊢)¨w
ops ← 'XOR' 'AND' 'OR'

{⍎∊(3↑⍵)(⊢/⍵),¨'←⍨'}¨v
⍎¨c,¨'←{('∘,¨a,¨'≠∧∨'[ops⍳op],¨b,¨⊂')⍵}'
⎕← 2⊥⍎'(',(join{⍵[⍒⍵]}c/⍨'z'=⊃¨c),')⍬'

xor and or ← ↓ops∘.≡op
M ← xor∧~∨⌿(⊃¨↑a b c)∊'xyz'
M∨← (~xor)∧('z'=⊣/↑c)∧'z45'∘≢¨c
M∨← and∧(c∊⊃,/xor∘/¨a b)∧⊃⍱/a b∊¨⊂⊂'x00'
M∨← xor∧(c∊⊃,/or∘/¨a b)∧⊃⍱/a b∊¨⊂⊂'x00'
⎕← join{⍵[⍋⍵]} M/c

