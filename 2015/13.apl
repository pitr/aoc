'pmat'⎕CY'dfns'

f ← ↓⍉↑ {' '(≠⊆⊢)¯1↓('lose '⎕R'gain -')⍵}¨ ⊃⎕NGET'in/13.txt'1

p1 p2 h ← f[0 10 3]
ppl ← ∪p1,p2

best ← {
    costs ← ⍵
    n ← (≢costs)-1
    ⌈/ {+/2{costs[⍺;⍵]+costs[⍵;⍺]}/⍵}¨ ↓n,(pmat n),n
}

⎕← best costs ← (⍎¨h)@(p1(,¨⍥(ppl∘⍳))p2)⊢(2/≢ppl)⍴0
⎕← best 0⍪0,costs
