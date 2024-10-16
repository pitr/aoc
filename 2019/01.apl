n ← ⍎¨⊃⎕NGET'in/01.txt'1

step ← {0⌈¯2+⌊⍵÷3}

⎕← +/ step n
⎕← +/s⊣ step⍣{s+←⍺ ⋄ ⍺≡⍵} n⊣ s ← n×0
