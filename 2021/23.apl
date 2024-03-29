p1 ← ⊖2 4⍴1+⎕A⍳ ∩∘⎕A ∊⊃⎕NGET'in/23.txt'1
p2 ← p1 {↑⌽1⌽⍺,⍵}⍥↓ 2 4⍴1+⎕A⍳∊'DCBA' 'DBAC'

cost ← 10*⍳4                        ⍝ cost per step
doors ← 2 4 6 8                     ⍝ door indices in hallway
between ← {+/×(⌊/⍵)↓(1+⌈/⍵)↑⍺}      ⍝ num of pods between ⍵ inclusively

⍝ cost to get from room to door and back
base ← {
    depth ← ⊃⍴⍵
    out ← +/∊cost[⍵-1]×4/⍪⌽1+⍳depth
    in  ← 10⊥4⍴2!1+depth
    out+in
}

⍝ input ∇ board -> [cost, board]
next ← {
    input  ← ⍺
    hall   ← 0@doors⊢⍵
    depths ← ⍵[doors]

    ⍝ optimal case: try to move pods into rooms
    in ← ⊃{
        0≠depths[hall[⍺]-1]: ⍵      ⍝ check if room is empty
        door ← doors[hall[⍺]-1]
        1≠(1↓⍵) between ⍺ door: ⍵   ⍝ check if pod can get to room
        cost ← (⊃⍵)+cost[hall[⍺]-1]×|door-⍺
        cost, 0@⍺⊢1↓⍵               ⍝ merge all boards, sum all costs
    }/(⍸×hall),⊂0,hall              ⍝ indices of pods in hallway
    0≠⊃in: ⊂depths@(1+doors)⊢in

    0=+/depths: ⍬                   ⍝ check for a dead end

    ⍝ general case: move pods out of rooms
    (⊂⍬)~⍨,(⍸×depths)∘.{
        pod ← input[depths[⍺]-1;⍺]
        door ← doors[⍺]
        0≠hall between door ⍵: ⍬    ⍝ check if pod can get out of room
        cost ← cost[pod-1]×|door-⍵
        cost, (-∘1)@door⊢depths@doors⊢pod@⍵⊢hall
    }(⍸0=hall)~doors
}

dfs ← {
    input  ← ⍵
    boards ← 1500⌶ ,0  ⍝ base case for empty board
    scores ←       ,0  ⍝   is 0

    {   key ← 5⊥⍵
        key∊boards: scores[boards⍳key]
        moves ← input next ⍵
        0=≢moves: ⌊/⍬
        scores ,← score ← ⌊/(⊃ + ∇⍤(1∘↓))¨moves
        boards ,← key
        score
    } (⊃⍴⍵)@doors⊢11⍴0
}

(base+dfs)¨ p1 p2
