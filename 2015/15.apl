'pmat'⎕CY'dfns'

cap dur flvr txtr kc ← ↓⍉↑('-',⎕D)∘(⍎¨∊⍨⊆⊢)¨⊃⎕NGET'in/15.txt'1
mat ← ↑cap dur flvr txtr
n ← ≢cap
opts ← ↓∪(0∘=-1∘=) pmat n

⍝ Part 1: start with equal share, and hill climb 1 teaspoon at a time
start ← {⍵/100÷⍵} ≢cap
⎕← start {
    other ← ×/0⌈↑(mat +.× ⊢)¨opts+⊂⍺
    ⍵≥max←⌈/other: ⍵
    max ∇⍨ ⍺+⊃opts[other⍳max]
} ×/0⌈mat +.× start

⍝ Part 2: depth first search
⎕← {
    (n-1)=≢⍵: ∇⍵,100-+/⍵
    n>≢⍵: ⌈/∇¨(⊂⍵),¨1+⍳100-+/⍵
    100≠+/⍵: 0
    500≠+/kc×⍵: 0
    ×/0⌈mat +.× ⍵
} ⍬
