alph ← ' ',⎕A
cranes moves ← {(×≢¨⍵)⊆⍵}⊃⎕NGET'in/05.txt'1
cranes ← {(⍵⍳0)↑⍵}¨↓⍉⊖↑{alph⍳∊⍵⊆⍨(≢⍵)⍴0 1 0 0}¨¯1↓cranes
moves ← {0 ¯1 ¯1+⍎¨(⍵∊⎕D)⊆⍵}¨moves
run ← {
    ∆ ← ⍺⍺
    alph[¯1↑¨⊃{
        num from to ← ⍺
        cranes ← ⍵
        box ← ∆(-num)↑from⊃cranes
        cranes[from] ← ⊂(-num)↓from⊃cranes
        cranes[to] ,← ⊂box
        cranes
    }/⌽(⊂cranes),⍵]
}

⎕← ⌽ run moves
⎕← ⊢ run moves
