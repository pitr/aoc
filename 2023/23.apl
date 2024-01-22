M ← '#^<>v.'⍳↑⊃⎕NGET'in/23.txt'1
D,← ⊂D←(-w)¯1 1(w←≢M)
end start ← 0 1

longest ← {
    ⍝ wgraph with only junctions
    graph costs ← ↓⍉↑{
        ↓⍉↑{⍵/⍨×≢¨⍵}⍵{⍬≡⍵: ⍬ ⋄ ⍵∊N: (N⍳⍵),≢⍺ ⋄ (⍺,⍵)∇(⍵⊃graph)~⍺}¨⍵⊃graph
    }¨N←end start,⍸2<≢¨graph←⍵

    ⍝ remove edges going back to start along outer walls
    outer ← ⍸4>≢¨graph
    graph costs ← {
        n ← ∪∊outer∘∩¨graph[⍵]
        n≡⍬: graph costs
        mask ← ~graph[n]∊¨⊂⍵
        graph[n] ← mask/¨graph[n]
        costs[n] ← mask/¨costs[n]
        ∇∪n
    }start

    ⍬ { end=⍵: +/costs[⍺]⊃⍨¨graph[⍺]⍳¨1↓⍺,end
        ⍬≡next←(⍵⊃graph)~⍺: 0
        ⌈/(⍺,⍵)∘∇¨next
    } start
}

⎕← longest {N⍳N∩∊⍵+D[⍵⊃,M-1]}¨N←¯1⌽⍸×,M
⎕← longest {N⍳N∩∊⍵+⊢/D}¨N←¯1⌽⍸×,M
