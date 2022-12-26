f ← ↓⍉↑' '(≠⊆⊢)¨ ⊃⎕NGET'in/14.txt'1
lim ← 2503
⍝names ← ⊃f
speed fly rest ← ⍎¨¨f[3 6 13]
runs ← +\¨lim⍴¨(rest+fly)↑¨fly⍴¨speed

⎕← ⌈/⊢/↑runs
⎕← ⌈/+/↑runs=⌈/runs
