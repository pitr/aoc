state ← '.#'∘⍳¨⊃f←↓⍉↑' '(≠⊆⊢)¨⊃⎕NGET'in/12.txt'1
groups ← ⍎¨1⊃f

solve ← {
    s g ← ⍺ ⍵                       ⍝ state and groups
    ⊃⊃{                             ⍝ return DP[0,0]
        n ← g[⍺]                    ⍝ size of current group
        p ← ⍸(n∧/×s)∧1≠n↓s,0        ⍝ spots where it can fit
        w ← ⍵[(≢s)⌊n+1+p]@p⊢⍵≠⍵     ⍝ and fits into next group
        p ← 1≠s                     ⍝ spots that shift left
        w[⍸p] +← ∊{⌽+\⌽⍵}¨w⊆⍨0,p    ⍝ shifted
        w                           ⍝ arrangements for group ⍺
    }/(⍳≢g),⊂⌽×\⌽1≠s,0              ⍝ starting with base case, reduce
}
⎕← +/state solve¨groups
state{1↓∊⍵/⊂2,⍺}¨← groups{∊⍵/⊂⍺}¨← 5
⎕← +/state solve¨groups
