M←'.#'⍳↑⊃⎕NGET'in/11.txt'1
x←⍸0=⌈⌿M ⋄ y←⍸0=⌈/M

count ← {|-\|-/↑(⍵⍸⍺)⍺} ⍝ range ∇ ns → # of ns inside, outside
⎕← .5×+/∊∘.{+/2   1×⊃+/(⍺,¨⍵)count¨y x}⍨⍸M
⎕← .5×+/∊∘.{+/1e6 1×⊃+/(⍺,¨⍵)count¨y x}⍨⍸M
