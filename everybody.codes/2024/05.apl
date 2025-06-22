parse ← {↓⍉↑⍎¨⊃⎕NGET('in/05_',⍵,'.txt')1}

round ← {
    cols ← ⍵
    a b ← (≢⍵)|⍺+⍳2
    n ← ⊃a⊃cols
    cols[a] ↓⍨← 1
    col ← b⊃cols
    sz ← 2×≢col
    ix ← {⍵⌊sz-⍵} sz|n-1
    (⊂(ix↑col),n,ix↓col)@b⊢cols
}

solve1 ← {∊(⍕⊃)¨⊃round/(⌽⍳10),⊂⍵}

solve2 ← {
    mem ← 0⍴⍨(≢⍵)/1+⌈/∊⍵
    0{
        cols ← ⍺ round ⍵
        mem[i←⊂⊃¨cols] +← 1
        2024=mem[i]: (⍺+1)×(⍎∊⍕¨∊i)
        (⍺+1) ∇ cols
    }⍵
}

solve3 ← {
    seen ← ⍬
    ppl ← {⍵[⍋⍵]}∪∊⍵
    mem ← 0⍴⍨(≢⍵)/≢ppl
    0{
        cols ← ⍺ round ⍵
        mem[i←⊂ppl⍳⊃¨cols] ← 1
        k ← ⊂∊⍕¨cols
        k∊seen: {∊⍕¨ppl[⊃⍵[(⍒⍵)⍳0]]}⍸mem
        seen,←k
        (⍺+1) ∇ cols
    }⍵
}

⎕← solve1 parse'1'
⎕← solve2 parse'2' ⍝ slow
⎕← solve3 parse'3' ⍝ really slow
