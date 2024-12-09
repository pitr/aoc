d ← ⎕D⍳⊃⊃⎕NGET'in/09.txt'1
n ← d/⌈.5×i×2|i←1+⍳≢d ⍝ 21121 becomes 1 1 0 2 0 0 3
gs gi ← d(0,+\d)⌷⍨¨⊂⊂1+2×⍳⌊.5×≢d ⍝ gap sizes and indices
sig ← {(0⌈⍵-1)+.×⍳⍴⍵}

⎕← sig (0+.<n)↑((0+.=n)↑⌽n~0)@(~×)n
⎕← sig {
    ⍵=0: n
    size ← d[2×⍵]
    g ← ⌊/gs⍳size+⍳10-size
    g=≢gs: ∇⍵-1
    i ← ⍸n=⍵+1
    gi[g]>⊃i: ∇⍵-1
    n[i] ← 0
    n[gi[g]+⍳size] ← ⍵+1
    gs[g]-← size
    gi[g]+← size
    ∇⍵-1
} ⌊.5×≢d
