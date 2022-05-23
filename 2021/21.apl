p1 p2 ← ¯1+(⍎1⊃∊∘⎕D⊆⊢)¨⊃⎕NGET'in/21.txt'1

{ ⍝ [part 1] ⍵ - cur/other player positions, cur/other scores, dice
    p q  s t  dice ← ⍵
    1000≤t: s×dice
    ∇ q p t (s+1+p←10|p+6+3×dice) (dice+3)
} 5↑p1 p2

sums freqs ← ↓⍉{⍺,≢⍵}⌸+/↑,1+⍳3 3 3

MEM ← 10 10 21 21 2⍴0
⌈/ { ⍝ [part 2] ⍵ - cur/other player positions, cur/other scores
    p q  s t ← ⍵
    21≤t: 0 1
    0∨.≠MEM[p;q;s;t;]: MEM[p;q;s;t;]
    ⊢MEM[p;q;s;t;] ← ⌽+⌿↑freqs × ∇¨ {q ⍵ t (s+⍵+1)}¨ 10|p+sums
} 4↑p1 p2
