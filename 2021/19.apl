'pmat' 'det'⎕CY'dfns'

f ← (⍎'¯'@('-'∘=))¨¨ ','(∊¨⊆⊢) ⊃⎕NGET'in/19.txt'1
m ← 12

manh ← +/|⍤-

⍝ all 24 90-degree rotation matrices.
rot ← {⍵/⍨1=det¨⍵},(↓pmat 3)∘.{⍵@(⍺,¨⍳3)⊢3 3⍴0} ,1-2×⍳2 2 2

⍝ for each scanner, find manhattan distances between each beacon.
dists ← {~∘0 , (</¨⍳2⍴≢⍵)×∘.manh⍨⍵}¨f

⍝ find scanner pairs with at least 66 common distances (2!12).
⍝ return bidirected graph in vector representation.
graph ← ⍸¨↓ (⊢∨⍉) ∘.{⍺≤⍵:0 ⋄ (2!m)≤((≢∩)×≢)/dists[⍺ ⍵]}⍨⍳≢f

resolve ← {             ⍝ resolve scanner ⍺ based on ⍺⍺, ⍵ is known origins
    0=⍺:(0 0 0)(⍺⊃f)    ⍝ scanner 0 has origin 0, beacons unchanged
    b ← ⍺⊃f             ⍝ beacons of ⍺
    po pb ← ⍺⍺⊃⍵        ⍝ parent's origin, beacons
    ⊃,/{
        b ← b(+.×)¨⊂⍵       ⍝ beacons with rotation matrix applied
        o ← ,pb∘.-b         ⍝ possible origins
        o ← ,/{m≤≢⍵:⍺⋄⊂⍬}⌸o ⍝ find origin repeated at least 12 times
        ⍬≡⊃o: ⍬             ⍝ break if no common origin found
        o,⊂b+¨o             ⍝ return ⍺'a new origin, beacons from that origin
    }¨rot
}

dfs ← {                 ⍝ ⍺ - current scanner, ⍺⍺ - parent, ⍵ - visited
    ⍬≢⍺⊃⍵: ⍵            ⍝ break if ⍺ was visited
    next ← ⍺⊃graph      ⍝ scanners connected to ⍺
    v ← ⊂⍺(⍺⍺resolve)⍵
    ⊃⍺ ∇∇/next, ⊂v@⍺⊢⍵  ⍝ traverse down
}

⍝ depth-first traversal of scanner graph.
scanners beacons ← ↓⍉↑ 0(¯1 dfs)(≢graph)⍴⊂⍬

≢↑ ∪/beacons
⌈/, ∘.manh⍨ scanners
