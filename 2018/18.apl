f ← '.|#'⍳↑⊃⎕NGET'in/18.txt'1

step ← {
    c ← 4 ⌷ n ← ,⍵
    0=c:   3≤1+.= n
    1=c: 1+3≤2+.= n
    2×1 2 ∧.≤ +/1 2∘.= n
}⌺3 3

score ← {×/+/1 2∘.=,⍵}
score step⍣10⊢f

run ← {
    mem ← 1500⌶ ⍬
    {   key ← ⊂⍵
        key∊mem: {⊃mem[⍵+(|⍵-≢mem)|1e9-⍵]} mem⍳key
        mem ,← key
        ∇ step ⍵
    } ⍵
}

score run f
