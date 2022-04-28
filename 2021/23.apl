p1 ← ,⍉2 4⍴1+⎕A⍳ ∩∘⎕A ∊⊃⎕NGET'in/23.txt'1
p2 ← ∊ p1 {¯1⌽⍵,⌽⍺}¨⍥(↓4 2∘⍴) 1+⎕A⍳'DDCBBAAC'

cost ← 0 , 10*⍳4                    ⍝ cost per step (ignore 0-index)
doors ← 2 4 6 8                     ⍝ door indices in hallway
between ← {+/0≠ (1+|-/⍵)↑(⌊/⍵)↓⍺}   ⍝ num of pods between ⍵ inclusively

⍝ cost to get from room to door and back
base ← {
    depth ← .25×≢⍵
    out ← +/∊{cost[⍵]×1+⍳depth}¨↓4 depth⍴⍵
    in  ← +/cost×0,4⍴2!1+depth
    out+in
}

moves ← {
    depth ← .25×(≢⍵)-11
    hall rooms ← (11↑⍵) (↓4 depth⍴11↓⍵)

    ⍝ heuristic: try to move pods into rooms
    in ← {⍵/⍨0≠≢¨⍵}{
        0=hall[⍵]: ⍬                ⍝ handle empty index
                                    ⍝ (because ¨ will run func even for empty array)
        0≠⊃⊃rooms[hall[⍵]-1]: ⍬     ⍝ check if room is empty
        door ← doors[hall[⍵]-1]
        1≠hall between ⍵,door: ⍬    ⍝ check if pod can get to room
        (cost[hall[⍵]]×|⍵-door), 0@⍵⊢hall
    }¨⍸×hall        ⍝ indices of pods in hallway
    0≠≢in: ⊂(∊rooms),⍨⊃(+⍥⊃ , ⌊⍥(1∘↓))/in

    ⍝ hall destinations
    dest ← (⍸0=hall)~doors

    ⍝ dead end detection, disregard boards that cannot move pods
    0=≢dest: ⍬

    ⍝ general case: move pods out of rooms
    ⊃,/{⍵/⍨0≠≢¨⍵}{
        room ← ⍵
        pod ← ⊃room⊃rooms
        src ← doors[room]
        to ← dest/⍨0={hall between src ⍵}¨dest
        0=≢to: ⍬        ⍝ check if pod can get out of room
        {(cost[pod]×|src-⍵), pod@⍵⊢hall, ∊(depth↑1∘↓)¨@room⊢rooms}¨to
    }¨⍸(×+/)¨rooms
}

solve ← {
    ⍝ base case: return score of 0 if hall and rooms are empty
    boards ← 1500⌶ ,⊂(11+≢⍵)⍴0
    scores ←       ,0

    ⍝ dfs search
    {
        key ← ⊂⍵
        key∊boards: scores[boards⍳key]
        next ← moves ⍵
        0=≢next: ⌊/⍬
        score ← ⌊/(⊃ + ∇⍤(1∘↓))¨next
        boards ,← key
        scores ,← score
        score
    } (11⍴0),⍵
}

(base+solve)¨ p1 p2
