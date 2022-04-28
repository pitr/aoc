'pmat' 'det'⎕CY'dfns'

f ← (⍎'¯'@('-'∘=))¨¨ ','(∊¨⊆⊢) ⊃⎕NGET'in/19.txt'1
m ← 12

manh ← +/∘|-

⍝ all 24 90-degree rotation matrices.
rot ← {⍵/⍨1=det¨⍵},(↓pmat 3)∘.{⍵@(⍺,¨⍳3)⊢3 3⍴0} ,1-2×⍳2 2 2

⍝ for each scanner, find manhattan distances between each beacon.
dists ← {~∘0 , (∘.<⍨⍳≢⍵)×∘.manh⍨⍵}¨f

⍝ find scanner pairs with at least 66 common distances (2!12).
⍝ return bidirected graph in vector representation.
graph ← ⍸¨↓ ∘.{⍺=⍵:0 ⋄ (2!m)≤(≢∩)/dists[⍺ ⍵]}⍨⍳≢f

⍝ ScannerID (ParentID ∇∇) Visited -> Origin Beacon
resolve ← {                 ⍝ resolve scanner based on a resolved parent scanner
    b ← ⍺⊃f                 ⍝ beacons of ⍺
    ¯1=⍺⍺:(3⍴0) b           ⍝ initial scanner has origin 0, beacons unchanged
    po pb ← ⍺⍺⊃⍵            ⍝ parent's origin, beacons
    ⊃{
        ⍬≢⍵: ⍵              ⍝ break if already resolved
        b ← b(+.×)¨⊂⍺       ⍝ beacons with rotation matrix applied
        o ← ,pb∘.-b         ⍝ possible origins
        o ← ,/{m≤≢⍵:⍺⋄⊂⍬}⌸o ⍝ find origin repeated at least 12 times
        ⍬≡⊃o: ⍵             ⍝ break if no common origin found
        o,⊂o+¨b             ⍝ return ⍺'a new origin, beacons from that origin
    }/rot,⊂⍬
}

⍝ ScannerID (ParentID ∇∇) Visited -> [Origin Beacons]
dfs ← {
    ⍬≢⍺⊃⍵: ⍵                ⍝ break if ⍺ was visited
    ob ← ⍺⍺ resolve/⍺ ⍵     ⍝ resolve origin, beacons for ⍺
    next ← ⍺⊃graph          ⍝ get next scanners to visit
    ⊃⍺ ∇∇/next, ⊂ob@⍺⊢⍵     ⍝ traverse down
}

⍝ depth-first traversal of scanners graph.
origins beacons ← ↓⍉↑ 0(¯1 dfs)(≢graph)⍴⊂⍬

≢⊃∪/beacons
⌈/,∘.manh⍨ origins
