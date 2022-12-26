'memo' 'cache'⎕CY'dfns'

code  ← ' '(≠⊆⊢)¨⊃⎕NGET'in/07.txt'1
wires ← (⊃⌽)¨code

_eval ← {
    ~(⊂⍵)∊wires: (16⍴2)⊤⍎⍵
    instr ← ¯2↓(wires⍳⊂,⍵)⊃code
    1=≢instr:  eval 0⊃instr
    2=≢instr: ~eval 1⊃instr
    'AND'≡1⊃instr:      (eval 0⊃instr)∧(eval 2⊃instr)
    'OR'≡1⊃instr:       (eval 0⊃instr)∨(eval 2⊃instr)
    'LSHIFT'≡1⊃instr:   16↑(⍎2⊃instr)↓(eval 0⊃instr)
    'RSHIFT'≡1⊃instr:   16↑(-16+⍎2⊃instr)↑(eval 0⊃instr)
}

eval ← _eval memo(cache ⍬)
⎕← a← 2⊥eval ,'a'

code[wires⍳⊂,'b'] ← ⊂(⊂⍕a)@0⊢(wires⍳⊂,'b')⊃code
eval ← _eval memo(cache ⍬)
⎕← 2⊥eval ,'a'
