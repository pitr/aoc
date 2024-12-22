D ← ≢g ← ↑⊃⎕NGET'in/16.txt'1
G ← ,g ⋄ S E ← G⍳'SE' ⋄ M ← 1e6
step ← { M@(⍸G='#')⊢⍵⌊(1+¯1(-D)1D⊖⍤2⊢⍵)⌊1e3+⊃⌊/1 3⌽¨⊂⍵ }
P ← step⍣≡0@(⊂S 0)⍉(4,≢G)⍴M
⎕← B ← ⌊/P[E;]

Q ← 2⌽step⍣≡0@(⊂E,⍸2⌽B=P[E;])⍉(4,≢G)⍴M
⎕← +/∨/B=P+Q
