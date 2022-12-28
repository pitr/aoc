n ← ⍎⊃⊃⎕NGET'in/06.txt'1
sz ← ≢n
seen ← ⍬

last ← {
    (⊂⍵)∊seen: ⊂⍵
    seen,← ⊂⍵
    i ← ⍵⍳⌈/⍵
    v ← ⍵[i]
    ∇ (0@i⊢⍵)+(-i+1)⌽sz↑+⌿↑(v⍴sz↑1)⊂v⍴1
} n

⎕← ≢seen
⎕← (≢seen)-seen⍳last
