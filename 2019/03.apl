n ← ','(≠⊆⊢)¨⊃⎕NGET'in/03.txt'1

⍝ s - steps
s ← {+\∊⍵}¨ {1 ¯1 0j1 0j¯1['RLUD'⍳⊃⍵]/⍨⍎1↓⍵}¨¨n
⍝ x - intersection points
x ← ⊃∩/s

⎕← ⌊/+⌿|9 11∘.○x
⎕← ⌊/2++⌿s∘.⍳x
