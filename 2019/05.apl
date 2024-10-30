N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/05.txt'1

vm ← ⎕FIX'vm.apl'

⎕← ⊃1 vm.run N
⎕← ⊃5 vm.run N
