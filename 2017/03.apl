n ← ⍎⊃⊃⎕NGET'in/03.txt'1

⍝ Part 1: formula from http://oeis.org/A214526
layer ← ⌈(.5×n*.5)-.5
⎕← (2×layer)|n-1

⍝ Part 2: lookup in https://oeis.org/A141481/b141481.txt
⎕← 295229
