f ← ⎕D⍳↑⊃⎕NGET'in/17.txt'1
D ← w 1(-w←≢f)¯1

⍝ M[n;dir;xy] is cost to xy in n steps from dir (D,R,U,L)
M ← ↑(⍳11)∘.{,(⊖⍉)⍣⍵⊢99⍪⍨⍣⍺⊢⍺+⌿1↓(⌽⍉)⍣⍵⊢f} ⍳4

F ← {best ← (≢,f)4⍴⌊/⍬ ⋄ ⍵{
    cost pos dir ← ⍵ ⋄ steps ← ⍺⍺
    0=≢cost: ⌊/⊢⌿best               ⍝ return best score once done
    dir ← 4|dir∘.+1 3               ⍝ new (orthogonal) directions
    val ← pos{M[steps;⍵;⍺]}¨↓dir    ⍝ cost to get move
    cost ← ,1 0 2⍉↑cost+val         ⍝ total cost
    pos ← ,pos+[1]steps∘.×D[dir]    ⍝   for new positions
    dir ← ∊(≢steps)/⊂dir            ⍝   in new directions
    cost pos dir /⍨←⊂99≠,1 0 2⍉↑val ⍝ remove positions outside bounds
    cost pos dir ⌷⍨←⊂⊂⍋cost         ⍝ sort by cost
    cost pos dir /⍨←⊂≠pos,⍥⍪dir     ⍝ remove duplicates
    m ← cost<best[i←pos,¨dir]
    best[i] ⌊← cost                 ⍝ record best so far
    cost pos dir /⍨←⊂m              ⍝ ignore costs that are higher than best
    ∇cost pos dir
}(0 0)(0 0)(0 1)}

⎕← F 1+⍳3
⎕← F 4+⍳7
