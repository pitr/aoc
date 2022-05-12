map ← {1@⍵⊢0⍴⍨2⍴1+⌈/∊⍵} {⎕A⍳⍵[5 36]}¨⊃⎕NGET'in/07.txt'1
workers duration ← 5 60

{⎕A[⍵]} {
    next ← ⍵ ~⍨ ⍸(+⌿map)=+⌿(⊂⍵)⌷map
    0=≢next: ⍵
    ∇ ⍵,⊃next
} ⍬

(0⍴⍨≢map) (0{
    next ← ⍵ ~⍨ ⍸(+⌿map)=+⌿(⊂⍵~⍸×⍺)⌷map
    (workers=+/×⍺) ∨ (∨/×⍺) ∧ 0=≢next: (0⌈⍺-⌊/⍺~0) ((⍺⍺+⌊/⍺~0)∇∇)⍵
    0=≢next: ⍺⍺
    ((duration+1+⊃next)@(⊃next)⊢⍺) ∇ ⍵,⊃next
}) ⍬

