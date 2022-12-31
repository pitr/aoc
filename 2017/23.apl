'factors'⎕CY'dfns'

n ← ⍎6↓⊃⊃⎕NGET'in/23.txt'1

⍝ decompiled
⎕← ×⍨n-2
⎕← +/1<(≢factors)¨ (100000+n×100)+ 17×⍳1+1e3
