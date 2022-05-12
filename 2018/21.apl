input ← ⍎⊃⎕D(∊⍨⊆⊢)8⊃⊃⎕NGET'in/21.txt'1

solve ← {
    c b a←256 256 256⊤⍵
    (16777216|65899×16777216|+)/(c+~2|c),b,a,input
}
solve 0
{ ⍺←⍬ ⋄ ⍵∊⍺: ⊃⌽⍺ ⋄ (⍺,⍵) ∇ solve ⍵ } 0
