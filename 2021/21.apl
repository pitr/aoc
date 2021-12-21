_ p1 _ p2 ← {⍎¨⍵⊆⍨(∊∘⎕D)¨⍵}⊃⎕NGET'in/21.txt'

∆ ← 1+ 10| -∘1

{ ⍝ ⍵ - cur/other player positions, cur/other scores, rolls
    p op s os t ← ⍵
    1000≤os: s×t
    p ← ∆+/p,100|1+t+⍳3
    ∇ op p os (s+p) (t+3)
} p1 p2 0 0 0   ⍝ part 1

sums freqs ← ↓⍉{⍺,≢⍵}⌸+/¨,1+⍳3 3 3

⌈/{ ⍝ ⍵ - cur/other player positions, cur/other scores
    p op s os ← ⍵
    os≥21: 0 1
    ⌽⊃+/freqs×∇¨{op,⍵,os,s+⍵}¨ ∆ p+sums
} p1 p2 0 0     ⍝ part 2
