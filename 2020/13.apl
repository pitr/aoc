start ← ⍎⊃start b ← ⊃⎕NGET'in/13.txt'1

x ← ⍬ ⋄ bus ← ⍎b
⎕← bus[t⍳⌊/t] × ⌊/t ← (bus~0)|-start

⎕FR ← 1287
x ← 0 ⋄ bus ← ⍎b
⍝ based on https://aplcart.info/?q=crt
gcd←{0=⍵:1 0 ⋄ (⍵∇⍵|⍺)+.×0 1,⍪1,-⌊⍺÷⍵}
crt←{m|⍵+.×⍺(⊣×⊢|∘⊃gcd)¨⍨⍺÷⍨m←×/⍺}
⎕← {⍵ crt ⍵-⍸×bus} bus~0
