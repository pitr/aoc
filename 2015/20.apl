n ← ⍎⊃⊃⎕NGET'in/20.txt'1

range ← {⍺+⍺×⍳⌊⍵÷⍺}
take ← (⌊∘≢)↑⊢

sz ← ⌊n÷10
c ← (sz+1)⍴1
_← {c[⍵ range sz]+←⍵ ⋄ 0}¨2+⍳sz
⎕← (c≥sz)⍳1

sz ← ⌊n÷11
c ← (sz+1)⍴1
_← {c[50 take ⍵ range sz]+←⍵ ⋄ 0}¨2+⍳sz
⎕← (c≥sz)⍳1
