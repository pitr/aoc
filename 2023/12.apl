state ← '.#'∘⍳¨⊃f←↓⍉↑' '(≠⊆⊢)¨⊃⎕NGET'in/12.txt'1
groups ← ⍎¨1⊃f

solve ← {
    ⊃⊃{ p ← ⍸(1≠⍺↓s,0)∧⍺∧/×s            ⍝ spots where it can fit
        w ← ⍵[(≢s)⌊⍺+1+p]@p⊢⍵≠⍵         ⍝ and fits into next group
        (∊{⌽+\⌽⍵}¨w⊆⍨0,1≠s)+@(⍸1≠s)⊢w   ⍝ shifted arrangements for group ⍺
    }/⍵,⊂⌽×\⌽1≠(s←⍺),0                  ⍝ starting with base case, reduce
}
⎕← +/state solve¨groups
state{1↓∊⍵/⊂2,⍺}¨← groups{∊⍵/⊂⍺}¨← 5
⎕← +/state solve¨groups
