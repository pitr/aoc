rules pages ← (×∘≢¨⊆⊢)⊃⎕NGET'in/05.txt'1
rules ← rules(⍎¨∊⊆⊣)¨⊂⎕D
fixed ← {⍵[⍒rules∊⍨∘.,⍨⍵]}¨pages ← ⍎¨pages
mid ← {⍵⊃⍨⌊.5×≢⍵}¨fixed
⎕← +/mid/⍨fixed≡¨pages
⎕← +/mid/⍨fixed≢¨pages
