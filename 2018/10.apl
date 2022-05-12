pos vel ← ↓⍉↑{↓2 2⍴⍎¨(⍵∊'-',⎕D)⊆⍵}¨⊃⎕NGET'in/10.txt'1
step ← vel∘+

show ← {
    min ← ⌊/⍵
    m ← ⍴∘0⊃1+(⌈/-⌊/)⍵
    ' ⎕'[⍉1@(⍵-min)⊢m]
}

part2 ← 0
show step⍣{part2 +← 1 ⋄ 9=⌊/⊃(⌈/-⌊/)⍺}⊢pos
part2
