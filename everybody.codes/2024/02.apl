parse ← {{(','(≠⊆⊢)6↓⊃⍵)(2↓⍵)} ⊃⎕NGET('in/02_',⍵,'.txt')1}

solve1 ← {+/∊⍷¨/⍵}
solve2 ← {
    w f←⍵
    w∪←⌽¨w
    +/∊∨⌿w∘.{∨/(-⍳≢⍺)⌽¨⊂⍺⍷⍵}f
}
solve3 ← {
    w f←⍵
    f ← ↑f
    a b c d ← (⊃∨/)¨↓⍉w∘.{⊃∨/s⌽¨∨⌿(-s)∘.⌽(⊂⍺)⍷¨(-s←⍳≢⍺)⌽¨⊂⍵}f(⌽f)(' ',⍉f)(' ',⌽⍉f)
    +/∊∨/a(⌽b)(1↓⍉c)(⊖1↓⍉d)
}

⎕← solve1 parse'1'
⎕← solve2 parse'2'
⎕← solve3 parse'3'
