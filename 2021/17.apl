x1 x2 y1 y2 ← ⍎¨((∊∘('-',⎕D))⊆⊣)'target area: x=20..30, y=-10..-5'

check ← {
    ⍺←0 0
    x y←⍺
    (x>x2)∨(y<y1): 0
    (x≥x1)∧(y≤y2): 1
    (⍺+⍵)∇(⊢⌈0 1∘×)⍵-1
}

result ← (10+⍳x2)∘.{check ⍺ ⍵} y1+⍳2×|y1

2!1+⌈/y1+⍸∨⌿result
+/,result
