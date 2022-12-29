dirs ←  'ne' (,'n') 'nw' 'se' (,'s') 'sw'
pos  ← ¯1j¯1   ¯2  ¯1j1 1j¯1     2   1j1

dist ← {(⊢⌿p)+.5×-⌿p←|9 11∘.○⍵}

f ← ','(≠⊆⊢)⊃⊃⎕NGET'in/11.txt'1

⎕← (⊢/ , ⌈/) dist +\pos[dirs⍳f]
