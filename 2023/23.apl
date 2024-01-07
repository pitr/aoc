M ← '#^<>v.'⍳↑⊃⎕NGET'in/23.txt'1
D,← ⊂D←(-w)¯1 1(w←≢M)
end start ← 0 1

⍝ ∇ graph → graph costs where graph is simplified
simplify ← {
    ↓⍉↑{
        ↓⍉↑⍵{
            ⍵∊N: (N⍳⍵),≢⍺
            (⍺,⍵)∇(⍵⊃graph)~⍺
        }¨⍵⊃graph
    }¨N←⍸2≠≢¨graph←⍵
}

solve ← {
    graph costs ← ⍵
    ⍬ {
        end=⍵: +/2{(⍵⍳⍨⍺⊃graph)⊃⍺⊃costs}/⍺,end
        ⍬≡next←(⍵⊃graph)~⍺: 0
        ⌈/(⍺,⍵)∘∇¨next
    } start
}

⎕← solve simplify {N⍳N∩∊⍵+D[⍵⊃,M-1]}¨N←¯1⌽⍸×,M
⎕← solve simplify {N⍳N∩∊⍵+⊢/D}¨N←¯1⌽⍸×,M
