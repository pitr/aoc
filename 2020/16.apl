rules ticket nearby ← {0 1 1↓¨(×≢¨⍵)⊆⍵}⊃⎕NGET'in/16.txt'1
ticket ← ⍎⊃ticket
nearby ← ↑⍎¨nearby
rules ← {∊{⍺+⍳1+⍵-⍺}/2 2⍴⍎¨(⍵∊⎕D)⊆⍵}¨rules

⎕← +/nearby[⍸0=valid←nearby∊∪∊rules]

nearby ⌿⍨← ∧/valid ⍝ keep only valid examples
matches ← ∧⌿¨⊂[⍳2]nearby ∘.∊ rules
⎕← ×/ticket[⍸∨⌿(sorted<6)⌿2<⌿0⍪↑matches[sorted←⍋+/¨matches]]
