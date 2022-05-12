f ← '#.GE'⍳↑⊃⎕NGET'in/15.txt'1

width ← 1⊃⍴f
D ← (-width) ¯1 1 width ⍝ '^<>v'

graph ← ,{⊂D/⍨(⊂1 3 5 7)⌷,×⍵[1;1]×⍵}⌺3 3⊢f
map ← ×,f

show ← {
    ⎕←(⍴f)⍴'#.GE'[(2+elf/⍨hp>0)@(pos/⍨hp>0)⊢map]
    ⎕←{⍵/⍨⍵>0}hp[⍋pos]
    1
}

move ← {
    hp[⍵]≤0: 'dead'
    p ← pos[⍵]
    ⍝ enemy
    targets ← ∪∊{⍵+graph[⍵]}¨pos/⍨(hp>0)∧elf≠elf[⍵]
    occupied← (hp>0)/pos
    p∊targets: 'already there'
    targets~← occupied
    ⍝ find best next move
    moves ← (∊p+⊃graph[p])~occupied
    next ← {
        ⍺←(≢⍵)⍴⊂⍬
        0=≢∊⍵: ⍬
        0<≢targets∩∊⍵: {
            moves[⊃⍸⍵(∨/∊)¨⌊/targets∩∊⍵]
        }⍵
        next ← ⍺{⍺~⍨ occupied~⍨ ∪∊⍵+graph[⍵]}¨⍵
        (⍺,¨⍵) ∇ next
    } ,¨moves
    ⍝ check for no moves
    0=≢next: 'no targets'
    pos[⍵] ← next
    'moved',p,'to',pos[⍵]
}

attack ← {
    hp[⍵]≤0: 1
    p ← pos[⍵]
    targets ← (hp>0)∧elf≠elf[⍵]
    0=+/targets: 0
    targets ∧← pos∊p+⊃graph[p]
    0=+/targets: 1
    targets ∧← hp=⌊/targets/hp
    target ← ⍸targets∧pos=⌊/pos/⍨targets
    elf[target]: 1⊣hp[target] -← 3
    1⊣hp[target] -← elfattack
}

run ← { ⍝ ⍵-elf attack
    elfattack ∘← ⍵
    pos elf ∘← {(⍸⍵∊2 3) (3=⍵~0 1)} ,f
    hp ∘← (≢pos)⍴200
    {
        full←∧/(attack⊣move)¨⍋pos
        0=+/0<hp/⍨elf:  (⍵+full)×+/hp/⍨hp>0
        0=+/0<hp/⍨~elf: (⍵+full)×+/hp/⍨hp>0
        ∇ ⍵+1
    } 0
}

run 3
run {1+⍵}⍣{(∧/0<elf/hp)⊣run ⍺}4

⍝ show map
