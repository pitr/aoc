N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/07.txt'1

vm ← ⎕FIX'vm.apl'
'pmat'⎕CY'dfns'

⎕← ⌈/{3 0⊃(⍺,⍵)vm.run N}/⍤1⌽0,pmat 5
⎕← ⌈/{
    m ← (vm.run∘N)¨⍵
    step ← {3 0⊃⊃m[⍺]←⊂⍵ vm.resume ⍺⊃m}
    {step/⌽⍵,⍳5}⍣≡0
}⍤1⌽0,5+pmat 5
