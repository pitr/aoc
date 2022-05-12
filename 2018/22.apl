⎕CY'dfns'

depth tx ty ← (⍎¨∊∘⎕D⊆⊢)∊⊃⎕NGET'in/22.txt'1
mx ← 10×tx

fmt ← {'.=|'[3|⍵]}

erosion ← 1(mx+1)⍴20183|depth+16807×⍳mx+1
map ← 3|erosion ⊣ {
    above ← ⊢⌿erosion
    ⊢erosion ⍪← ⌽⊃{⍵,⍨20183|depth+⍺×⊃⍵}/⌽(20183|depth+48271×⍵)@0⊢above
}¨ 1 to ty
map[ty;tx] ← 0

+/∊(1+ty tx)↑map
