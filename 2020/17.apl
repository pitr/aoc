cube ← ↑'#'=⊃⎕NGET'in/17.txt'1
life ← {3=n-⍵×4=n←{+/∊⍵}⌺(3/⍨≢⍴⍵)⊢⍵}⍣6

⍝ smallest values that work for my input
⎕← +/∊ life ¯13     ¯18 ¯19↑7   12 13↑(1  ,⍴cube)⍴cube
⎕← +/∊ life ¯13 ¯13 ¯17 ¯19↑7 7 11 13↑(1 1,⍴cube)⍴cube
