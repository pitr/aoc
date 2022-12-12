dist ← {+/ | 9 11○⍵}
lines ← {(~⍵∊', ')⊆⍵}⊃⊃⎕NGET'in/01.txt'1

d ← 0j1×1-2×'R'=⊃¨lines
s ← (⍎1∘↓)¨lines

⎕← dist +/s××\d
⎕← dist {⍵[⊃⍸0=≠⍵]}⊃{⍵,⍺+⊃⌽⍵}/⌽0,s{⍵×1+⍳⍺}¨×\d
