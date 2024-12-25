d ← ⎕D⍳⊃⊃⎕NGET'in/09.txt'1
n ← d/⌈.5×i×2|i←1+⍳≢d
gs gi ← d(0,¯1↓+\d)/⍨¨⊂(≢d)⍴0 1
sig ← {(0⌈⍵-1)+.×⍳⍴⍵}

⎕← sig (0+.<n)↑((0+.=n)↑⌽n~0)@(~×)n
⎕← sig n⊣{
    s ← d[2×⍵]
    g ← ⌊/gs⍳s+⍳10-s
    g=≢gs: 0
    i ← ⍸n=⍵+1
    gi[g]>⊃i: 0
    n[i] ← 0
    n[gi[g]+⍳s] ← ⍵+1
   ⊢gi[g]+← gs[g]-← s
}¨⌽⍳⌈/n
