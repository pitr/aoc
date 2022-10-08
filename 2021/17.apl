x1 x2 y1 y2 ← ⍎¨((∊∘('-',⎕D))⊆⊣)⊃⎕NGET'in/17.txt'

check ← {
    ⍺ ← 0 0
    x y ← ⍺
    x y1 ∨.> x2 y: 0
    x y2 ∧.≥ x1 y: 1
    (⍺+⍵) ∇ (⊢⌈0 1×⊢)⍵-1
}

2!|y1                               ⍝ part 1
+/check¨, (⍳x1+x2) ∘., y1+⍳2×|y1    ⍝ part 2
