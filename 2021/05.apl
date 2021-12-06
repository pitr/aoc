n ← {⍉ 2 2⍴ ⍎¨ (⍵∊⎕D)⊆⍵}¨ ⊃⎕NGET'in/05.txt'1

solve ← {
    coords ← {⊃,¨/ {⍺- (×d)× ⍳1+| d←⍺-⍵}/⍵}
    +/ {2≤≢⍵}⌸ ⊃,/ coords¨⍵     ⍝ flatten and count repetitions
}

solve ((∨/=/)¨n)/n  ⍝ part 1
solve n             ⍝ part 2