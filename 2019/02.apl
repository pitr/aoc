N ← ⍎⊃⊃⎕NGET'in/02.txt'1

vm ← ⎕FIX'vm.apl'

⎕← 1 0⊃ vm.run 12 2@1 2⊢N
⎕← 100⊥⊃⍸19690720= ∘.{1 0⊃ vm.run ⍺ ⍵@1 2⊢N}⍨⍳99
