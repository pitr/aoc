:Namespace VM

    ⍝ n ∇ ix → [] with autogrow
    acc ← { (⊃⍵)<≢⍺: ⍺[⍵] ⋄ ⍵∇⍨(1+⊃⍵)↑⍺}
    ⍝ (val ∇ ix) n → @ with autogrow
    at ← { ⍵⍵<≢⍵: ⍺⍺@⍵⍵⊢⍵ ⋄ ∇(⍵⍵+1)↑⍵ }
    ⍝ n (pc,rc ∇∇) arg → arg's val
    get ← { m ← ⍵⊃1↓⌽(5⍴10)⊤⍺[⊃⍺⍺]  ⋄ 0=m: ⍺acc⍺[⍵+⊃⍺⍺]     ⋄ 1=m: ⍺[⍵+⊃⍺⍺] ⋄ 2=m: ⍺acc⍺[⍵+⊃⍺⍺]+1⊃⍺⍺ }
    ⍝ n (pc,rc ∇∇ arg) val → n with arg set to val
    set ← { m ← ⍵⍵⊃1↓⌽(5⍴10)⊤⍺[⊃⍺⍺] ⋄ 0=m: ⍵at(⍺[⍵⍵+⊃⍺⍺])⊢⍺ ⋄ 1=m: panic    ⋄ 2=m: ⍵at(⍺[⍵⍵+⊃⍺⍺]+1⊃⍺⍺)⊢⍺ }
    ⍝ n (op ∇∇ nxt) pc,rc → calls nxt
    alu ← { (⍺(⍵set 3) ⍺⍺/⍺∘(⍵get)¨1 2) ⍵⍵ ⍵+4 0 }
    ⍝ n (op ∇∇ nxt) pc,rc → calls nxt
    jmp ← { v j←⍺∘(⍵get)¨1 2 ⋄ 0⍺⍺v: ⍺ ⍵⍵ j@0⊢⍵ ⋄ ⍺ ⍵⍵ ⍵+3 0 }

    step ← { ⍝ n (in ∇∇ out) pc,rc → n,in,out,(pc,rc)
        op ← 100|⍺[⊃⍵]
        1=op: ⍺+alu∇⍵ ⋄ 2=op: ⍺×alu∇⍵
        5=op: ⍺≠jmp∇⍵ ⋄ 6=op: ⍺=jmp∇⍵
        7=op: ⍺<alu∇⍵ ⋄ 8=op: ⍺=alu∇⍵
        4=op: ⍺ (⍺⍺ ∇∇ (⍵⍵,⍺(⍵get)1)) ⍵+2 0
        9=op: ⍺ ∇ ⍵+2,⍺(⍵get)1
        99=op: 0 ⍺ ⍺⍺ ⍵⍵ ⍵
        3≠op: panic
        0=≢⍺⍺: 1 ⍺ ⍺⍺ ⍵⍵ ⍵
        (⍺(⍵set 1)⊃⍺⍺) ((1↓⍺⍺) ∇∇ ⍵⍵) ⍵+2 0
    }
    run ← { ⍺←⍬ ⋄ ⍵(⍺step⍬)0 0 } ⍝ in ∇ n → phase,n,in,out,(pc,rc)
    resume ← { ⍝ in ∇ state → run VM with more input
        phase n in out pcrc ← ⍵
        1≠phase: ⍵
        0≠≢in: panic
        n (⍺ step ⍬) pcrc
    }

:EndNamespace
