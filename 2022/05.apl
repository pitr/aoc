cranes moves ← {(×≢¨⍵)⊆⍵}⊃⎕NGET'in/05.txt'1
cranes ← {(⍵/⍨1=4|⍳⍴⍵)∩¨⊂⎕A}↓⍉↑cranes
moves ← {0 ¯1 ¯1+⍎¨(⍵∊⎕D)⊆⍵}¨moves

run ← {
    boxes ← ⍺⍺ (⊃⍺)↑⊃⍵[⍺[1]]
    ((⊂(⊃⍺)↓⊃),(⊂boxes,1⊃⊢))@(1↓⍺)⊢⍵
}

⎕← ⊃¨⊃⌽run/⌽(⊂cranes),moves
⎕← ⊃¨⊃⊢run/⌽(⊂cranes),moves
