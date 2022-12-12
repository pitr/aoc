⍝ based on disassembled code
fib ← {⊃(+\⌽)⍣⍵⊢1 2}

X ← ×/ {⍎(⍵∊⎕D)/⍵}¨ (⊂16 17)⌷⊃⎕NGET'in/12.txt'1
⎕← {X + fib ⍵}¨ 26 + 0 7

)off
code ← ' '(≠⊆⊢)¨⊃⎕NGET'in/12.txt'1
reg ← 'abcd'
run ← {
    ⍺←0
    ip regs ← ⍺⍵
    ip≥≢code: regs[0]
    op ← ⊃inst ← ip⊃code
    'dec'≡op: (ip+1) ∇ ¯1∘+@(reg⍳⊃⊃inst[1])⊢regs
    'inc'≡op: (ip+1) ∇ 1∘+@(reg⍳⊃⊃inst[1])⊢regs
    src ← {reg∊⍨⊃⍵: regs[reg⍳⊃⍵] ⋄ ⍎⍵} 1⊃inst
    'cpy'≡op: (ip+1) ∇ src@(reg⍳2⊃inst)⊢regs
    'jnz'≢op: 'err'
    0=src: (ip+1) ∇ regs
    (ip+⍎2⊃inst) ∇ regs
}
⎕← run 0 0 0 0
⎕← run 0 0 1 0 ⍝ takes over a minute
