'bsearch'⎕CY'dfns'

n ← ⍎⊃⊃⎕NGET'in/07.txt'1

tri     ← 2!1+⊢             ⍝ Triangular number, 1+2+..+⍵
median  ← ⊢⌷⍨⍋⌷⍨(⌊.5×≢)

one ← {+/     | n - ⍵}
two ← {+/ tri | n - ⍵}

⍝ First solution, O(n×m)

⌊/ one ¨⍳⌈/n
⌊/ two ¨⍳⌈/n

⍝ Second solution using binary search, O(n×log(m))

one (⊢ <⍥one 1+⊢) bsearch 0,⌈/n
two (⊢ <⍥two 1+⊢) bsearch 0,⌈/n

⍝ Third solution using median/mean, O(n×log(n)) and O(n)

one median n
(⌊ ⌊⍥two ⌈) (+/÷≢) n

⍝ Paper with proof that dx is within mean +/- 0.5
⍝ https://www.reddit.com/r/adventofcode/comments/rawxad
