data ← (⎕JSON¨¨(×≢¨)⊆⊢)⊃⎕NGET'in/13.txt'1

compare ← {
    i j ← 0=≡¨⍺⍵        ⍝ 1. check if integers
    i∧j: ⍺(<->)⍵
    i∨j: ∇/(⊂,)@j⊢⍺⍵

    ∨/e←0=≢¨⍺⍵: -/e     ⍝ 2. check if empty

    0≠h←∇/⊃¨⍺⍵: h       ⍝ 3. compare heads
    ∇/1↓¨⍺⍵             ⍝ 4. compare tails
}

⎕← +/ 1+⍸ 1=compare/¨data
⎕← ×/ 1 2+ +⌿ 1= 2 6 ∘.compare⍨ ⊃,/data
