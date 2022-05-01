p1 ← ,⍉2 4⍴1+⎕A⍳ ∩∘⎕A ∊⊃⎕NGET'in/23.txt'1
p2 ← ∊ p1 {¯1⌽⍵,⌽⍺}⍥(4 2∘⍴) 1+⎕A⍳'DDCBBAAC'

cost ← 0 , 10*⍳4                    ⍝ cost per step (ignore 0-index)
doors ← 2 4 6 8                     ⍝ door indices in hallway
between ← {+/×(⌊/⍵)↓(1+⌈/⍵)↑⍺}      ⍝ num of pods between ⍵ inclusively

⍝ cost to get from room to door and back
base ← {
    depth ← .25×≢⍵
    out ← cost[⍵]+.×(≢⍵)⍴1+⍳depth
    in  ← 10⊥4⍴2!1+depth
    out+in
}

⍝ ∇ board -> [cost, board]
next ← {
    depth ← .25×(≢⍵)-11
    hall rooms ← (11↑⍵) (↓4 depth⍴11↓⍵)

    ⍝ optimal case: try to move pods into rooms
    in ← ⊃{
        ×⊃⊃rooms[hall[⍺]-1]: ⍵      ⍝ check if room is empty
        door ← doors[hall[⍺]-1]
        1≠(1↓⍵) between ⍺ door: ⍵   ⍝ check if pod can get to room
        cost ← (⊃⍵)+cost[hall[⍺]]×|door-⍺
        cost, 0@⍺⊢1↓⍵               ⍝ merge all boards, sum all costs
    }/(⍸×hall),⊂0,hall              ⍝ indices of pods in hallway
    ×⊃in: ⊂in,∊rooms

    ⍝ general case: move pods out of rooms
    (⊂⍬)~⍨,(⍸×⊃¨rooms)∘.{
        pod ← ⊃⍺⊃rooms
        door ← doors[⍺]
        0≠hall between door ⍵: ⍬    ⍝ check if pod can get out of room
        (cost[pod]×|door-⍵), pod@⍵⊢hall, ∊(depth↑1∘↓)¨@⍺⊢rooms
    }(⍸0=hall)~doors
}

dfs ← {
    boards ← 1500⌶ ,⊂(11+≢⍵)⍴0  ⍝ base case for empty board
    scores ←       ,0           ⍝   is 0

    {   key ← ⊂⍵
        key∊boards: scores[boards⍳key]
        moves ← next ⍵
        0=≢moves: ⌊/⍬
        scores ,← score ← ⌊/(⊃ + ∇⍤(1∘↓))¨moves
        boards ,← key
        score
    } (11⍴0),⍵
}

(base+dfs)¨ p1 p2
