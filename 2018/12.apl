input ← 15↓⊃f ← '#'=⊃⎕NGET'in/12.txt'1
on ← {(2⊥5∘↑)¨⍵/⍨9⌷¨⍵}2↓f
next ← on∊⍨ 2⊥¨ 5,/ 4⌽ (8/0), ⊢
generation ← {.25×(≢⍵)-≢input}
score ← {+/(⍸⍵)-2×generation ⍵}

score next⍣20⊢input

stable ← next⍣(≡⍥(⍸-⍳∘1)) input ⍝ stabilize the pattern
{⍵ + (⍵-⍨score next stable) × 50e9-generation stable} score stable
