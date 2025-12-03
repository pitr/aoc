s ← {
    d ← ⌈/(1-⍺)↓⍵       ⍝ find largest digit, leaving room at the end
    ⍺=1: d              ⍝ base case
    d,(⍺-1)∇(1+⍵⍳d)↓⍵   ⍝ recurse with the rest of digits
}⍤1

f ← ⎕D⍳↑⊃⎕NGET'in/03.txt'1

⎕← 10⊥+⌿ 2s f
⎕← 10⊥+⌿12s f
