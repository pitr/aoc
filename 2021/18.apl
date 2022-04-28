parse ← {
    punc ← '[],'∘.=⍵
    nums ← ⍎¨(~∨⌿punc) ⊆ ⍵
    dpth ← ⊃¨(~∨⌿punc) ⊆ -⌿+\2↑punc
    nums dpth
}

explode ← {
    a i j b ← ¯1 0 1 2+⍵⍳5
    k ← (1-≢)b↓⍺
    nums ← (¯1↓i↑⍺),(⍺[i]+a↓i↑⍺),0,(⍺[j]+k↓b↓⍺),1↓b↓⍺
    dpth ← (i↑⍵),(⍵[i]-1),b↓⍵
    nums dpth
}

split ← {
    i j ← 0 1+(9<⍺)⍳1
    nums ← (i↑⍺), ((⌊,⌈).5×⍺[i]), j↓⍺
    dpth ← (i↑⍵), (2⍴1+⍵[i]), j↓⍵
    nums dpth
}

simplify ← {
    s e ← 9 4 < ⌈/¨⍵
    e: ∇ ⊃explode/⍵
    s: ∇ ⊃split/⍵
    ⍵
}

add ← simplify 0 1+,¨

mag ← {
    1=≢1⊃⍵: ⊃⍵
    i j ← 0 2+dpth⍳⌈/dpth ← 1⊃⍵
    nums ← {(i↑⍵),(+/3 2×2↑i↓⍵), j↓⍵}⊃⍵
    dpth ← {(i↑⍵),(⍵[i]-1), j↓⍵}dpth
    ∇ nums dpth
}

f ← parse¨⊃⎕NGET'in/18.txt'1

mag ⊃add⍨/ ⌽f
⌈/∊∘.(mag⍤add × ≢)⍨f
