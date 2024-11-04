N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/13.txt'1

vm ← ⎕FIX'vm.apl'

⎕← 2+.=⊢/{⍵⍴⍨3,⍨(⍴⍵)÷3}3⊃vm.run N

⎕← (24 44⍴0) {
    map ← ⍺
    score ← ∊{x y b←⍵ ⋄ x=¯1:b ⋄ ⍬⊣map[y;x]←b}¨↓{⍵⍴⍨3,⍨(⍴⍵)÷3} 3⊃⍵
    ⍝ ⎕← ' ⎕*-o'[map]⊣⎕DL÷10 ⍝ show the map
    0=⊃⍵: score
    map∇⍵vm.resume⍨×-/{0 1⊃⍸⍵=map}¨ 4 3
} vm.run 2@0⊢N
