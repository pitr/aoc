data ← (⍎¨∊∘⎕D⊆⊢)¨⊃⎕NGET'in/20.txt'1

merge ← {
    a b ← ⍺
    c d ← ⍵
    c≤b+1: a,b⌈d
    ⍵
}
ranges ← merge\data[⍋⊣/¨data]
⎕← 1+⊢/∊ranges[⊢/⍸0=⊃¨ranges]
⎕← (4294967295+1) - +/1--/↑ranges[⍸⌽≠⌽⊣/¨ranges]
