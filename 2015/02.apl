l w h ← ⍪¨↓⍉↑'x'(⍎¨≠⊆⊢)¨⊃⎕NGET'in/02.txt'1

⎕← +/ (⌊/+2×+/) (l×w),(w×h),(h×l)
⎕← +/(×/l,w,h) + 2×⌊/(l+w),(w+h),(h+l)
