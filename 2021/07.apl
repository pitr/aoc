'bsearch'⎕CY'dfns'

n ← ⍎⊃⊃⎕NGET'in/07.txt'1

tri     ← 2!1+⊢             ⍝ Triangular number, 1+2+..+⍵
median  ← ⊢⌷⍨(⌊.5×≢)⌷⍋

⍝ First solution, O(n×m)

dx ← | n ∘.- ⍳⌈/n

⌊/ +⌿ dx
⌊/ +⌿ tri dx

⍝ Second solution using binary search, O(n×log(m))

+/     | n- { </ {+/     | n-⍵}¨ ⍵+⍳2 } bsearch 0,⌈/n
+/ tri | n- { </ {+/ tri | n-⍵}¨ ⍵+⍳2 } bsearch 0,⌈/n

⍝ Third solution using median/mean, O(n×log(n)) and O(n)

+/ | n - median n
⌊/ { +/ tri | n-⍵ }¨ (⌈,⌊) (+/÷≢) n

⍝ Paper with proof that dx is within mean +/- 0.5
⍝ https://www.reddit.com/r/adventofcode/comments/rawxad
