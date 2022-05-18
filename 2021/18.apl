parse ← {
    punc ← '[],'∘.=⍵
    nums ← ⍎¨(~∨⌿punc) ⊆ ⍵
    dpth ← ⊃¨(~∨⌿punc) ⊆ -⌿+\2↑punc
    nums dpth
}

explode ← { nums dpth ← ⍵
    dpth∧.≤4: ⍵
    a i j b c ← ¯1 0 1 2 3+dpth⍳5
    k ← c-≢nums
    nums ← (¯1↓i↑nums),(nums[i]+a↓i↑nums),0,(nums[j]+b↓k↓nums),(c↓nums)
    dpth ← (i↑dpth),(dpth[i]-1),(b↓dpth)
    nums dpth
}

split ← { nums dpth ← ⍵
    nums∧.≤9: ⍵
    i j ← 0 1+(nums>9)⍳1
    nums ← (i↑nums), ((⌊,⌈)nums[i]÷2), j↓nums
    dpth ← (i↑dpth), (2⍴1+dpth[i]), j↓dpth
    nums dpth
}

merge ← split∘(explode⍣≡)⍣≡ 0 1+,¨

mag ← { nums dpth ← ⍵
    1=≢dpth: nums
    i j ← 0 2+dpth⍳⌈/dpth
    nums ← (i↑nums), (+/3 2×2↑i↓nums), (j↓nums)
    dpth ← (i↑dpth), (dpth[i]-1), (j↓dpth)
    ∇ nums dpth
}

f ← parse¨⊃⎕NGET'in/18.txt'1

mag ⊃merge⍨/ ⌽f
⌈/∊∘.(mag⍤merge × ≢)⍨f
