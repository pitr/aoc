M ← '#'=↑⊃⎕NGET'in/11.txt'1
d ← (⌈/∘.,⍥(+\~)⌈⌿)M

⎕← +/0⌈∊∘.-⍨M/⍥,(⍳⍴M)+d
⎕← +/0⌈∊∘.-⍨M/⍥,(⍳⍴M)+d×1e6-1
