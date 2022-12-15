to ← {(⍺⌊⍵)+⍳1+|⍺-⍵}
walls ← ∪∊ {2{+/1 0j1×⍺ to¨⍵}/ ↓(.5×≢l)2⍴ l←⍎¨(⍵∊⎕D)⊆⍵}¨ ⊃⎕NGET'in/14.txt'1
floor ← 1+⌈/11○walls
down ← 0j1 + 0 ¯1 1

⍝ Part 1. Depth-first search: mid-left-right post-order iterative traversal
⍝ ⍺ - stack ⋄ ⍺⍺ - visited ⋄ ⍵ - count ⋄ terminates once floor is reached
⎕← 500 (walls{⊃(⍺⍺∪c)∇∇/(floor=11○c)↓(⊂next,1↓⍺),⊂⍵+⍬≡next ← ⍺⍺ ~⍨ (down+c),c←⊃⍺}) 0

⍝ Part 2. Breadth-first search: count all possible places for sand at each depth
⍝ ⍺ - grains from a level above ⋄ ⍵ - count per level
⎕← +/ 500 { ⊃∇/ (floor=≢⍵)↓ (⊂next),⊂⍵,≢next ← (∪∊down+⊂⍺) ~ walls } 1
