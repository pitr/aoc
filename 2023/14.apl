f ← {1,⌽⍉⍵}⍣4⊢'.#'⍳↑⊃⎕NGET'in/14.txt'1
F ← {n+⍵-¯1⊖n←2×⍵<1⊖2=⍵}⍣≡
S ← {+/(⌽⍳≢⍵)+.×2=⍵}
⎕← S F f
⎕← ⍬ { (≢⍺)>i←⍺⍳⊂n←{⌽⍉F⍵}⍣4⊢⍵: S⊃⍺[i+((≢⍺)-i)|1e9-1+i] ⋄ (⍺,⊂n) ∇ n } f
