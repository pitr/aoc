f ← ↑'-'(≠⊆⊢)¨⊃⎕NGET'in/12.txt'1

small ← ⍸25=⎕A⍸nodes ← ∪'start' 'end',,f
graph ← (0~⍨⍸)¨↓1@(↓nodes⍳f⍪⌽f)⊢{⍵ ⍵⍴0}≢nodes

dfs ← {                 ⍝ count paths
    ⍺ ← 0               ⍝ initialize start node
    ⍺=1: 1              ⍝ return 1 on end
    ⍺ ⍺⍺ ⍵∩small: 0     ⍝ return 0 on stop condition
    +/ ∇∘(⍵,⍺)¨ ⍺⊃graph ⍝ sum paths to next nodes
}

∊ dfs ⍬
(∊ ∧ (⊢≢∪)⍤⊢) dfs ⍬
