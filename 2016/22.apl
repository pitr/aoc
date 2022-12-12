disks ← ⎕D∘(⍎¨∊⍨⊆⊢)¨ 2↓⊃⎕NGET'in/22.txt'1

⎕← +/∊∘.(≢ ∧ (×3⊃⊣) ∧ (3⊃⊣)≤4⊃⊢)⍨ disks

⍝ part 2 is solved manually by visualizing the map
⎕← 45 + 30×5  ⍝ empty->goal + goal->origin × #moves-per-step

sh     ← 1+⊃⌈/2↑¨disks
empty  ← 1×0=3⊃¨disks
full   ← 2×100<3⊃¨disks
origin ← 3×(≢disks)↑1
goal   ← 4×(≢disks)↑(-1+×/sh-1 0)↑1
⎕← '._#○G'[⍉sh⍴empty+full+origin+goal]
