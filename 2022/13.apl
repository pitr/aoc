data ← (⎕JSON¨¨(×≢¨)⊆⊢)⊃⎕NGET'in/13.txt'1

compare ← {
    i1 i2 ← 0=≡¨⍺⍵      ⍝ check if integers
    i1∧i2: ⍺ (<->) ⍵
    i1: (,⍺) ∇ ⍵
    i2: ⍺ ∇ (,⍵)
    e1 e2 ← 0=≢¨⍺⍵      ⍝ check if empty
    e1∨e2: e1-e2
    0≠f←∇/⊃¨⍺⍵: f       ⍝ compare heads
    ∇/1↓¨⍺⍵             ⍝ compare tails
}

⎕← +/ 1+⍸ (1=compare/)¨data
⎕← ×/ 1 2+ +⌿ (⊃,/data) ∘.(1=compare) ⎕JSON¨ '[[2]]' '[[6]]'
