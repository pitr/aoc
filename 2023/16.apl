f ← ('#',⌽∘⍉)⍣4⊢↑⊃⎕NGET'in/16.txt'1
next ← {
    x y dx dy ← ⍵
    x y+←dx dy-1
    c←f[y;x]
    c='.': ⊂x y dx dy
    c='|': (x y 1 2)(x y 1 0)
    c='-': (x y 2 1)(x y 0 1)
    c='\': ⊂x y   dy dx
    c='/': ⊂x y,2-dy dx
    ⍬
}
solve←{
    seen ← 0⍴⍨(⍴f),3 3
    {
        0=≢⍵: +/∊∨/∨/seen
        n ← ⊃,/next¨⍵
        n≡⍬: ∇n
        n/⍨ ← ~seen[n]
        seen[n]←1
        ∇n
    }⍵
}
⎕← solve ⊂0 1 2 1
h w←⍴f
p ← ⊃,/{(0 ⍵ 2 1)((w-1) ⍵ 0 1)}¨⍳h
p,← ⊃,/{(⍵ 0 1 2)(⍵ (h-1) 1 0)}¨⍳w
⎕← ⌈/{solve⊂⍵}¨p
