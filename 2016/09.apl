line ← ⊃⊃⎕NGET'in/09.txt'1
parse ← { (⍎¨'x'(≠⊆⊢)1↓end↑⍵),end←⍵⍳')' }

⎕← {
    ⍺ ← 0
    0=≢⍵: ⍺
    '('≠⊃⍵: (⍺+d) ∇ (d←⍵⍳'(')↓⍵
    len rep end ← parse ⍵
    (⍺+rep×len) ∇ (1+end+len)↓⍵
} line

⎕← {
    ⍺ ← 0
    0=≢⍵: ⍺
    '('≠⊃⍵: (⍺+d) ∇ (d←⍵⍳'(')↓⍵
    len rep end ← parse ⍵
    sub ← 0 ∇ len↑1↓end↓⍵
    (⍺+rep×sub) ∇ (1+end+len)↓⍵
} line
