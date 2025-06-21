parse ← {'.#'⍳↑⊃⎕NGET('in/03_',⍵,'.txt')1}

solve ← {
    mask ← ⍺
    +/∊ {⍺+{⌊/mask/∊⍵}⌺3 3⊢⍵}⍣≡⍨⍵
}

⎕← (9⍴⍳2) solve parse'1'
⎕← (9⍴⍳2) solve parse'2'
⎕← (9⍴1)  solve parse'3'
