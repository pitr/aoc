n ← ⎕D⍳⊃⊃⎕NGET'in/09.txt'1
d ← n/⌈.5×i×2|i←1+⍳≢n
sig ← {+/(0⌈⍵-1)×⍳⍴⍵}
⎕← sig {~0∊⍵:⍵ ⋄ d↓⍨-⊥⍨0=d←¯1↓(⊢/⍵)@(⍵⍳0)⊢⍵}⍣≡d
⎕← sig⊃{
    s ← +/⍺=⍵
    fits ← (1/⍨s)⍷⍵=0
    ~1∊fits: ⍵
    ix ← fits⍳1
    ix>⍵⍳⍺: ⍵
    ⍺@(ix+⍳s)⊢0@(⍸⍵=⍺)⊢⍵
}/(∪d~0),⊂d
