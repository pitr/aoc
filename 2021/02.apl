forward ← 0,⍨⊢ ⋄ up ← 0,- ⋄ down ← 0,⊢

n ← ↑⍎¨ ⊃⎕nget'02.txt'1

×/ +⌿ n             ⍝ part 1

f a ← ↓⍉n           ⍝ forward/aim
×/+⌿f,⍪f×+\a        ⍝ part 2