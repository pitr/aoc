f ← 1↓⍉↑((×≢¨)⊆⊢)⊃⎕NGET'in/11.txt'1
f ← ('× old'⎕R'* 2')¨('\*'⎕R'×')¨f
items arg mod true false ← ↓{⍎(⊃⍸⍵∊⎕D)↓⍵}¨f
op ← '+×*'⍳23⌷¨f[1;]
math ← { 0=⍺⍺: ⍺+⍵ ⋄ 1=⍺⍺: ⍺×⍵ ⋄ 2=⍺⍺: ⍵*⍺ }
MOD ← ∧/mod

run ← {
    div num ← ⍺⍵
    pck ← ,¨items
    inspects ← (≢items)⍴0
    _← {
        items ← MOD|⌊div÷⍨arg[⍵] (op[⍵]math)¨ (⍵⊃pck)
        0=≢items: ⍵
        inspects[⍵]+← ≢items
        to ← (⍵⊃¨true false)[×mod[⍵]|items]
        pck[⍵] ← ⊂⍬
        ⍵⊣to {pck[⍺],← ⍵}¨ items
    }¨⍣num⊢⍳≢items
    ×/inspects[2↑⍒inspects]
}

⎕← 3 run 20
⎕← 1 run 1e4
