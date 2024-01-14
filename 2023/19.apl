flows ratings ← (×≢¨f)⊆f←⊃⎕NGET'in/19.txt'1
A ← +/ ⋄ R ← 0⍨
src ← '\{'           ','  '}'
dst ← '←{x m a s←⍵⋄' '⍵⋄' '⍵}'
(⍎src⎕R dst)¨flows
⎕← +/{in⍎¨⍵⊆⍨⍵∊⎕D}¨ratings

A ← ×/+/ ⋄ v ← 1+⍳4e3 ⋄ x m a s ← ⍳4

⍝      init state   M mask, ∆ applies mask, r sum     last term
src ← '\{'         '(.)([<>]\d+):([ARa-z]+),'        '([ARa-z]+)}'
dst ← '←{r←0⋄w←⍵⋄' '∆←∧@\1⋄r+←\3 w ∆⍨M←v\2⋄w ∆⍨←~M⋄' 'r+\1 w}'
(⍎src⎕R dst)¨flows
⎕← in 4 4e3⍴1
