⎕CY'dfns'

f ← (⎕D,⎕C⎕A)∘(∊⍨⊆⊢)¨⊃⎕NGET'in/07.txt'1
names ← ⊃¨f
costs ← 1(⍎⊃)¨f
graph ← {(names⍳⊂)¨2↓⍵}¨f

⎕← ⊃names[start←⊃(⍳⍴names)~∊graph]
_←{
    kids ← ⍵⊃graph
    ⍬≡kids: costs[⍵]
    kids ← ∇¨kids
    1=≢∪kids: costs[⍵]++/kids
    good ← ⊃kids/⍨0=≠kids
    grow ← good-kids~good
  ⎕ ← grow+costs[(kids≠good)/⍵⊃graph]
    costs[⍵]++/good⍨¨kids
} start
