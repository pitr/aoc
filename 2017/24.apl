c ← (⌊/,⌈/)¨'/'(⍎¨≠⊆⊢)¨⊃⎕NGET'in/24.txt'1
best ← 100⍴0

_←{
    l←⊃⌽⍵
    past ← 2(⌊,⌈)/,⍵
    nxt ← (c/⍨∨/¨c∊¨l)~past
    0<≢nxt: ∇¨⍵∘,¨{(~⍵⍳l)⊃⍵}¨nxt~past
    best[≢⍵] ⌈← (2×+/⍵)-⊃⌽⍵
    0
} 0
⎕← ⌈/best
⎕← ⊢/best~0
