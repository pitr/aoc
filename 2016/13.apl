n ← ⍎⊃⊃⎕NGET'in/13.txt'1

f ← {x←9○⍵ ⋄ y←11○⍵ ⋄ 0=2|+⌿2⊥⍣¯1⊢n + (x×x) + (3×x) + (2×x×y) + y + (y×y)}
dir ← ¯1j0 1j0 0j1 0j¯1

run ← { ⍝ [visited] (steps ∇∇ (steps ∇ next)) [next]
    ⍺←⍬
    visited ← ⍺∪⍵
    next ← (f next)/next ← {⍵/⍨∧/0≤↑9 11∘○¨⍵} ∪∊⍵+⊂dir
    ⍺⍺ ⍵⍵ next: ⍺⍺ visited
    visited ((⍺⍺+1)∇∇⍵⍵) next~visited
}

⎕←  0⊃(1 run {31j39∊⍵}) ,1j1
⎕← ≢1⊃(1 run {50<⍺}) ,1j1
