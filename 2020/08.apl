f ← ⊃⎕NGET'in/08.txt'1
ip←val←0
acc←{val+←⍵ ⋄ ip+←1} ⋄ nop←{ip+←1} ⋄ jmp←{ip+←⍵}
run ← {p←ip ⋄ p≥≢f:1 ⋄ p∊⍵:0 ⋄ _←⍎p⊃f ⋄ ∇⍵,p}
⎕← val⊣run⍬

acc←{val+←⍵ ⋄ ip+←1} ⋄ nop←{ip+←1 ⍵[ip=swap]} ⋄ jmp←{ip+←⍵ 1[ip=swap]}
swap ← 0
⎕← val⊣1+⍣{swap+←1 ⋄ ip×←val×←0 ⋄ run⍬}0
