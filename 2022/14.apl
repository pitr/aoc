f ← ⊃,/ {2{↑⍺⍵}/ ↓{(.5×≢⍵)2⍴⍵} ⍎¨ (⍵∊⎕D)⊆⍵}¨ ⊃⎕NGET'in/14.txt'1

coords ← {⊃,¨/ {⍺- (×d)× ⍳1+| d←⍺-⍵}⌿⍵} ⍝ all coords between two points
map ← 1@(⊃∪/coords¨ f)⊢(3+2 1×⌈⌿⊃⌈/f)⍴0 ⍝ create a map

part ← {
    done ← {
        x y ← ⍵
        ∨/⍵=¯1+⍴map: 1                  ⍝ stop condition 1: fall out of map
        0=map[x;y+1]: ∇ ⍵+0 1           ⍝   fall down
        0=map[x-1;y+1]: ∇ ⍵+¯1 1        ⍝   OR fall left and down
        0=map[x+1;y+1]: ∇ ⍵+1 1         ⍝   OR fall right and down
        2=map[x;y]: 1                   ⍝ stop condition 2: reach source
        0⊣map[x;y]←2                    ⍝ base case: land
    } 500 0                             ⍝ start at source
    done: 2+.=∊map                      ⍝ count grains once done
    ∇⍵
}

⎕← part 1
map[;¯1+1⊃⍴map] ← 1                     ⍝ part 2: floor
⎕← part 2
