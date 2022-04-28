hex ← '0123456789ABCDEF'
f ← ∊{2 2 2 2⊤hex⍳⍵}¨⊃⊃⎕NGET'in/16.txt'1

read ← { ⊃res f ∘← ⍵(⊂⍤↑ , ⊂⍤↓)f }
eval ← { ⍺=0:+/⍵ ⋄ ⍺=1:×/⍵ ⋄ ⍺=2:⌊/⍵ ⋄ ⍺=3:⌈/⍵ ⋄ ⍺=5:>/⍵ ⋄ ⍺=6:</⍵ ⋄ ⍺=7:=/⍵ }

sum ← 0

packet ← {
    sum+← 2⊥read 3
    typ ← 2⊥read 3
    4=typ: 2⊥{val←1↓l←read 5 ⋄ ⊃l: val,∇⍵ ⋄ val}⍬
    ⊃read 1: typ eval ∇¨⍳2⊥read 11
    len ← (≢f)-2⊥read 15
    sub←⍬ ⋄ _←{sub,←packet ⍬}⍣{len=≢f}⍬
    typ eval sub
}

part2 ← packet ⍬
sum         ⍝ part 1 (calculated during parsing/evaling)
part 2      ⍝ part 2
