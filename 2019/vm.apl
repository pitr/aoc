:Namespace VM

    ⍝ n (pc ∇∇) arg → arg's val
    get ← { m ← ⍵⊃1↓⌽(5⍴10)⊤⍺[⍺⍺]  ⋄ 0=m: ⍺[⍺[⍺⍺+⍵]]     ⋄ 1=m: ⍺[⍺⍺+⍵] }
    ⍝ n (pc ∇∇ arg) val → n with arg set to val
    set ← { m ← ⍵⍵⊃1↓⌽(5⍴10)⊤⍺[⍺⍺] ⋄ 0=m: ⍵@(⍺[⍺⍺+⍵⍵])⊢⍺ ⋄ 1=m: panic }
    ⍝ n (op ∇∇ nxt) pc → pc
    alu ← { (⍺(⍵set 3) ⍺⍺/⍺∘(⍵get)¨1 2) ⍵⍵ ⍵+4 }
    ⍝ n (op ∇∇ nxt) pc → pc
    jmp ← { v j←⍺∘(⍵get)¨1 2 ⋄ 0⍺⍺v: ⍺ ⍵⍵ j ⋄ ⍺ ⍵⍵ ⍵+3 }

    step ← { ⍝ n (in ∇∇ out) pc
        op ← 100|⍺[⍵]
        1=op: ⍺+alu∇⍵ ⋄ 2=op: ⍺×alu∇⍵
        5=op: ⍺≠jmp∇⍵ ⋄ 6=op: ⍺=jmp∇⍵
        7=op: ⍺<alu∇⍵ ⋄ 8=op: ⍺=alu∇⍵
        4=op: ⍺ (⍺⍺ ∇∇ (⍵⍵,⍺(⍵get)1)) ⍵+2
        99=op: 0 ⍺ ⍺⍺ ⍵⍵ ⍵
        3≠op: panic
        0=≢⍺⍺: 1 ⍺ ⍺⍺ ⍵⍵ ⍵
        (⍺(⍵set 1)⊃⍺⍺) ((1↓⍺⍺) ∇∇ ⍵⍵) ⍵+2
    }
    run ← { ⍺←⍬ ⋄ ⍵(⍺step⍬)0 } ⍝ in ∇ n → phase,n,in,out,pc
    resume ← { ⍝ in ∇ state → run VM with more input
        phase n in out pc ← ⍵
        1≠phase: ⍵
        0≠≢in: panic
        n (⍺ step ⍬) pc
    }

:EndNamespace
