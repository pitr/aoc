lines ← ⊃⎕NGET'in/10.txt'1
vals ← +\∊1,∊{'noop'≡⍵:0 ⋄ 0,⍎5↓⍵}¨lines

⎕← +/{⍵×vals[⍵-1]} 20+40×⍳6
⎕← ' #'[1≥|vals-⍥{6 40⍴⍵}⍳40]
