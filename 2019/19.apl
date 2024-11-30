N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/19.txt'1
vm ← ⎕FIX'vm.apl' ⋄ check ← ⊃3⊃vm.run∘N

⎕← +/∊check¨⍳50 50

⎕← {
    0=check⍵: ∇⍵+0 1
    0=check⍵+¯99 99: ∇⍵+1 0
    10000⊥⍵-99 0
} 500 500
