file ← 1↓⍉↑((×≢¨)⊆⊢)⊃⎕NGET'in/11.txt'1
file ← ('× old'⎕R'* 2')¨('\*'⎕R'×')¨file
items arg mod true false ← ↓{⍎(⊃⍸⍵∊⎕D)↓⍵}¨file
op ← '+×*'⍳23⌷¨file[1;]
math ← { 0=⍺⍺: ⍺+⍵ ⋄ 1=⍺⍺: ⍺×⍵ ⋄ 2=⍺⍺: ⍵*⍺ }
MOD ← ∧/mod

run ← {
    num mul ← ⍺⍵
    pack ← ,¨items
    inspects ← (≢items)⍴0
    _← {
        items ← MOD|⌊mul× arg[⍵] (op[⍵]math)¨ ⍵⊃pack
        0=≢items: ⍵
        pack[⍵] ← ⊂⍬
        inspects[⍵]+← ≢items
        to ← ⍵⊃¨true false[×mod[⍵]|items]
        ⍵⊣to {pack[⍺],← ⍵}¨ items
    }¨⍣num⊢⍳≢pack
    ×/inspects[2↑⍒inspects]
}

⎕← 20  run ÷3
⎕← 1e4 run 1
