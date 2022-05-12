f ← ⍎⊃⊃⎕NGET'in/08.txt'1

read ← { ⊃res i ∘← (f[i+⍳⍵]) (i+⍵) }

run ← {
    i ∘← 0 ⋄ ⍺⍺ {
        n m ← read 2
        n=0: +/read m
        +/ (read m) ⍺⍺ 0,∇¨⍳n
    } ⍵
}

, run 0
{⍵[⍺ ∩ 1↓⍳≢⍵]} run 0
