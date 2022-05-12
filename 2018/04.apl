schedule ← 4000 60⍴0
minute ← ⍬

{
    last ← ⍎⊃⌽ n←(⍵∊⎕D)⊆⍵
    6=≢n:       guard ∘← last
    ⍬≡minute:   minute∘← last
    schedule[guard; minute+⍳|minute-last] +← 1
    minute ∘← ⍬
}¨{⍵[⍋⍵]}⊃⎕NGET'in/04.txt'1

max ← {⊃⍸⍵=⌈/⍵}

{⍵×max ⍵⌷schedule} max +/schedule
{⍵×max ⍵⌷schedule} max ⌈/schedule
