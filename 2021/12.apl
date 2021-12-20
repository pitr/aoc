f ← ↑'-'(≠⊆⊢)¨⊃⎕NGET'in/12.txt' 1

small ← ⍸25=⎕A⍸nodes ← ∪'start' 'end',,f
graph ← ⍸¨↓1@(↓nodes⍳f⍪⌽f)⊢(2⍴≢nodes)⍴0

dfs ← {                     ⍝ count paths
    ⍺ ← ⍬                   ⍝ initialize visited
    ⍵=1: 1                  ⍝ return 1 on end
    ⍵ ⍺⍺ ⍺∩small: 0         ⍝ return 0 on stop condition
    +/ (⍺,⍵)∘∇¨(⍵⊃graph)~0  ⍝ sum paths to next nodes (omit start)
}

∊ dfs 0
(∊∧⊢≢∪⍤⊢) dfs 0
