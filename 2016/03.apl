in ← ↑⍎¨⊃⎕NGET'in/03.txt'1
check ← {+/m<(+/⍵)-m←⌈/⍵}
⎕← check in
⎕← check (⍴in)⍴,⍉in
