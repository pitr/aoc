lines ← ⊃⎕NGET'in/09.txt'1
moves ← +\ 0,(1(⍎↓)¨lines) / 0j1*'RDLU'⍳⊃¨lines

run ← ⊃{
    head tails ← ⍺⍵
    tail ← ⊢/tails
    dist ← 9 11○head-tail
    move ← +/¯9 ¯11○×dist
    tails, (dist≢×dist) ↑ tail+move
}/∘⌽

⍝ 40% faster
run ← ⊃(⊢,(≢∘×⍨dist)↑tail+( +/¯9 ¯11○∘×(dist←9 11○⊣-(tail←⊢/⊢))))/∘⌽

⎕← ≢∪run   moves
⎕← ≢∪run⍣9⊢moves
