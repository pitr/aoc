HP ATK ← ⎕D(⍎¨∊⍨⊆⊢)∊⊃⎕NGET'in/22.txt'1

costs ← 53 73 113 173 229
turns ← 1 1 6 6 5
hps   ← 0 2 0 0 0
atks  ← 4 2 0 3 0
defs  ← 0 0 7 0 0
manas ← 0 0 0 0 101

run ← {
    mana spent hp Ehp bossturn decay ← 6↑⍵
    turn ← 6↓⍵
    0≥hp: ⍺

    ⍝ apply spells
    hp  +← +/hps/⍨×turn
    Ehp -← +/atks/⍨×turn
    mana+← +/manas/⍨×turn
    d    ← +/defs/⍨×turn
    turn-← ×turn
    0≥Ehp: spent
    ⍝ a) boss turn
    bossturn: ⍺ ∇ mana,spent,(hp-1⌈ATK-d),Ehp,0,decay,turn
    ⍝ b) player turn
    hp  -← decay
    0≥hp: ⍺
    avl ← ⍸(⍺>spent+costs)∧(0=turn)∧mana≥costs
    avl≡⍬: ⍺
    ⌊/⍺∇¨{(mana-costs[⍵]),(spent+costs[⍵]),hp,Ehp,1,decay,turns[⍵]@⍵⊢turn}¨avl
}

⎕← 1000 run 500 0 50 HP 0 0,costs=0
⎕← 1300 run 500 0 50 HP 0 1,costs=0
