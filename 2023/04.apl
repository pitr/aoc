c ← {≢⊃∩/⍎¨1↓⍵⊆⍨~⍵∊':|'}¨⊃⎕NGET'in/04.txt'1

⎕← +/⌊2*c-1
n←c=c ⋄ {n+←n[⍵]×(-1+⍵)⌽(≢c)↑c[⍵]⍴1}¨⍳≢c
⎕← +/n
