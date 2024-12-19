'memo' 'cache'⎕CY'dfns'
t ← 'wubrg'(∊⍨⊆⊢)⊃f ← ⊃⎕NGET'in/19.txt'1
count ← {
    ⍵≡'': 1
    n←∪≢¨t/⍨⊃¨t⍷¨⊂⍵
    0=≢n: 0
    +/count¨n↓¨⊂⍵
} memo (C←cache ⍬)
⎕← +/×c←count¨2↓f
⎕← +/c
