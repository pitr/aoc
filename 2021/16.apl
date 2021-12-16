f ← ∊{2 2 2 2⊤dec⍵}¨¯1↓⊃⎕NGET'in/16.txt'

read ← { ret←⍵↑f ⋄ f↓⍨←⍵ ⋄ ret }
eval ← {⍺=0:+/⍵ ⋄ ⍺=1:×/⍵ ⋄ ⍺=2:⌊/⍵ ⋄ ⍺=3:⌈/⍵ ⋄ ⍺=5:>/⍵ ⋄ ⍺=6:</⍵ ⋄ ⍺=7:=/⍵}

sum ← 0

packet ← {
    sum+← 2⊥read 3
    typ ← 2⊥read 3
    lit ← {val←1↓l←read 5 ⋄ ⊃l:val,∇ ⍵ ⋄ val}
    4=typ: 2⊥lit ⍵
    ⊃read 1: typ eval ∇¨⍳2⊥read 11
    len ← (≢f)-2⊥read 15
    sub←⍬ ⋄ _←{sub,←packet ⍬}⍣{len=≢f}⍬
    typ eval sub
}

packet ⍬    ⍝ part 2
sum         ⍝ part 1 (calculated during parsing/evaling)
