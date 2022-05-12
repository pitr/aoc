f   ← ⊃⎕NGET'in/19.txt'1
ip  ← ⍎⊃⌽⊃f
asm ← 1↓f

addr ← { (+/reg[2↑⍵])@(2⊃⍵)⊢reg  }
addi ← { (reg[⊃⍵]+1⊃⍵)@(2⊃⍵)⊢reg }
mulr ← { (×/reg[2↑⍵])@(2⊃⍵)⊢reg  }
muli ← { (reg[⊃⍵]×1⊃⍵)@(2⊃⍵)⊢reg }
setr ← { (reg[⊃⍵])@(2⊃⍵)⊢reg     }
seti ← { (⊃⍵)@(2⊃⍵)⊢reg          }

score ← +/(∪⊢∨⍳) ⍝ sum of divisors

reg ← 5↑0
score reg[2]⊣{ 1+ip⌷reg ∘← ⍎⊃asm[reg[ip]←⍵] }⍣{0=reg[ip]}⊢0

reg ← 5↑1
score reg[2]⊣{ 1+ip⌷reg ∘← ⍎⊃asm[reg[ip]←⍵] }⍣{0=reg[ip]}⊢0
