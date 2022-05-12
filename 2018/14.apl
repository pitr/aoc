part1 ← 10⊥part2 ← ⍎¨⊃⊃⎕NGET'in/14.txt'1

lookup  ← ∘.(⍎¨∘⍕+)⍨⍳10
scores  ← 3 7
batch  ∘← ⍬

_←{
    turns ← 1+⌊10÷⍨(≢scores)-1+⌈/⍵
    batch ∘← ⍬
    next ← { ⍵+1+ batch,← scores[⍵] }⍣turns⊢⍵
    scores ,← ∊lookup[↓turns 2⍴batch]
    (≢scores)|next
}⍣4⍣{∨/part2⍷scores} 0 1

10⊥scores[part1+⍳10]
⍸part2⍷scores
