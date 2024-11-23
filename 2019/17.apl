N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/17.txt'1

vm ← ⎕FIX'vm.apl'

d ← '.#^v<>'⍳⎕UCS↑10(≠⊆⊢)3⊃vm.run N
⎕← +/×/↑⍸{4=+/∊×⍵[1;1]×∊⍵×3 3⍴0 1}⌺3 3⊢d

⍝ show map, solve part 2 by hand
⍝ ⎕← '.#^v<>'[d]

a ← ⎕UCS'R,6,L,10,R,8'
b ← ⎕UCS'R,8,R,12,L,8,L,8'
c ← ⎕UCS'L,10,R,6,R,6,L,8'
m ← ⎕UCS'A,B,A,B,C,A,B,C,A,C'
i ← ∊m a b c (⎕UCS'n'),¨10
⎕← ⊢/3⊃i vm.run 2@0⊢N
