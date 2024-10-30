:Namespace VM

    ⍝ mode (pc GET) arg → arg's val
    get ← { 0=⍺: n[n[⍺⍺+⍵]]    ⋄ 1=⍺: n[⍺⍺+⍵] }
    ⍝ mode (pc SET arg) val - sets arg to val
    set ← { 0=⍺: n[n[⍺⍺+⍵⍵]]←⍵ ⋄ 1=⍺: panic }
    ⍝ mode (op ALU) pc → pc
    alu ← { ⍵+4⊣ ⍺[3](⍵set 3) ⍺⍺/⍺[1 2](⍵get)¨1 2 }
    ⍝ mode (op JMP) pc → pc
    jmp ← { v j←⍺[1 2](⍵get)¨1 2 ⋄ 0⍺⍺v:j ⋄ ⍵+3 }
    ⍝ mode (op CMP) pc → pc
    cmp ← { ⍵+4⊣⍺[3](⍵set 3) ⍺⍺/⍺[1 2](⍵get)¨1 2 }

    step ← {
        op ← 100|z←n[⍵] ⋄ m ← 1↓⌽(5⍴10)⊤z
        1=op: m+alu⍵ ⋄ 2=op: m×alu⍵
        5=op: m≠jmp⍵ ⋄ 6=op: m=jmp⍵
        7=op: m<cmp⍵ ⋄ 8=op: m=cmp⍵
        3=op: ⍵+2⊣ inp∘←1↓inp⊣ m[1](⍵ set 1)⊃inp
        4=op: ⍵+2⊣ out,←m[1](⍵get)1
        99=op: ⍵
    }
    run ← { ⍺←⍬ ⋄ n∘←⍵ ⋄ inp∘←⍺ ⋄ out∘←⍬ ⋄ out n⊣step⍣≡0 }

:EndNamespace
