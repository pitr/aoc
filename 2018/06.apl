f ← ⍎¨⊃⎕NGET'in/06.txt'1
map ← {1<+/l=⌊/l←+/¨|f∘.-⊂⍵: 0 ⋄ 1+⊃⍸l=⌊/l}¨⍳2×⊃⌈/f

⌈/{≢⍵}⌸~∘0∊map×~map∊∪∊¯1 1{(∊⍺↑⍵),∊⍺↑[1]⍵}¨⊂map
+/∊{10000>+/∊|f∘.-⊂⍵}¨⍳2×⊃⌈/f