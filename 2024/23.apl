c ← '-'(≠⊆⊢)¨⊃⎕NGET'in/23.txt'1
V ← ∪⊃,/c
E ← (⊢∨⍉)1@(V∘⍳¨c)⊢(2/⍴V)⍴0
show ← ⊃{⍺,',',⍵}/

⎕← ≢∪{⍵[⍋⍵]}¨{⊃,/{(⊂⍵),¨⍸∧⌿E[,⍵;]}¨⍵}⍣2⊢⍸'t'=⊃¨V
⎕← show {⍵[⍋⍵]} V[⊃C[(⊢⍳⌈/)≢¨C←{⍵,n↑⍨×≢n←⍸∧⌿E[,⍵;]}⍣≡¨⍳⍴V]]
