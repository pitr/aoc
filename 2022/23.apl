elfs ← 1500⌶ {+/0j1 1×⍵}¨⍸'#'=↑⊃⎕NGET'in/23.txt'1
nei  ← ¯1j1 1 1j1 0j1  ¯1 ¯1j¯1 0j¯1 1j¯1
dirs ← 0j¯1 0j1 ¯1 1

move ← {
    elfs ← ⍺⍺
    0=+/(⍵+nei)∊elfs: ⍵
    ⍵+(d,0)[1⍳⍨⍵{0=+/elfs∊⍨⍺+⍵(⍵+⍵×0j1)(⍵-⍵×0j1)}¨d←dirs[4|⍺+⍳4]]
}

next ← {
    valid ← ∊{⊂(1=≢⍵)↑⍺}⌸to ← ⍺ (⍵ move) ¨⍵
    1500⌶ valid , (~to∊valid)/⍵
}

⎕← {(≢⍵) -⍨ (×/1+⌈/-⌊/)9 11∘.○⍵} ⊃next/⌽(⊂elfs),⍳10
⎕← elfs {⍺≡a← ⍵ next ⍺: ⍵+1 ⋄ a ∇ ⍵+1} 0
