x1 x2 y1 y2 ← ⍎¨((∊∘('-',⎕D))⊆⊣)⊃⎕NGET'in/17.txt'

check ← {
    x y ← ⍺
    ∨/ x y1 > x2 y: 0
    ∧/ x y2 ≥ x1 y: 1
    (⍺+⍵) ∇ (⊢⌈0 1×⊢)⍵-1
}

2!|y1                                   ⍝ part 1
+/,(⍳x1+x2)∘.(0 0∘check,) y1+⍳2×|y1     ⍝ part 2
