f ← ¯1↓1↓ ⊃⊃⎕NGET'in/20.txt'1

rooms ← stack ← 1 2⍴0
{
    ⍵='(': stack ⍪← ⊢⌿rooms
    ⍵=')': stack ↓⍨← ¯1
    ⍵='|': rooms ⍪← ⊢⌿stack
           rooms ⍪← (⊢⌿rooms)+1,0j1*'NESW'⍳⍵
}¨f

depths ← ⊃{⌊/⍵}⌸/⌽↓⍉↑rooms
⌈/depths
+/depths≥1e3
