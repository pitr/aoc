solve ← {
    f ← {⍵⊆⍨~⍵∊',:'}¨⊃⎕NGET('in/06_',⍵,'.txt')1
    n ← ⊃∪/f ⍝ names
    g ← ⍳≢n  ⍝ parent vector
    a ← g≠g  ⍝ has apples/pests
    _ ← (f⍳⍨¨⊂n) {
        g[1↓⍺] ← ⊃⍺
        ⊢a[⊃⍺] ← ∨/⍵∊⍺
    }¨ ⊂⍸∨/n∘.≡','(≠⊆⊢)'@,BUG,ANT'
    e ← n⍳⊂'RR'
    n ← ⍺⍺¨n
    {
        p ← g[⊣/⍵]
        1=e+.=p: '@',⍨∊n[e,⍵[p⍳e;]]
        ∇(e≠p)⌿p,⍵
    } ⍪a/⍳≢g
}

⎕← ⊢solve'1'
⎕← ⊃solve'2'
⎕← ⊃solve'3'
