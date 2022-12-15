x y bx by ← ↓⍉↑{⍎¨(⍵∊⎕D,'-')⊆⍵}¨ ⊃⎕NGET'in/15.txt'1
r ← ⊃+/ | x y - bx by

row ← 10 2e6[14<≢x]
to ← {(⍺⌊⍵)+⍳1+|⍺-⍵}
dy ← r - |row-y
covered ← ⊃{⍵∪⊃(-to+)/⍺}/⌽(⊂⍬), (0≤dy)/x,¨dy
beacons ← (row=by)/bx
⎕← ≢ covered ~ beacons

max ← 20 4e6[14<≢x]
d1 d2 ← {(y+⍵)(-∪+)(r+1)}¨ (-x)x
⎕← ⊃∊ d1 ∘.{
    pos ← ⌊.5× ⍵(-,+)⍺
    (0≥pos) ∨.∨ (pos≥max): ⍬
    r ∨.≥ ⊃pos +.(|-) x y: ⍬
    pos +.× 4e6 1
} d2
