f ← ⊃⎕NGET'in/25.txt'1
steps ← ⊃⎕D(⍎¨∊⍨⊆⊢)1⊃f
sm ← ↑{v m n←↓3 2⍴22 22 27 27 26 26⊃¨⍵[2 6 3 7 4 8] ⋄ ⍉↑(v='1')(1-2×'l'=m)(⎕A⍳n)}¨1↓(⊢⊆⍨0<≢¨)f

ex ← 1e4
tape ← (2×ex)⍴0
{ (⊃⍵)0+1↓vms⊣tape[ex+⊃⍵]←⊃vms←sm[1⊃⍵;tape[ex+⊃⍵];] }⍣steps⊢0 0
⎕← +/tape
