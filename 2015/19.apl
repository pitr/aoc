start ← ⊃¯1↑f←⊃⎕NGET'in/19.txt'1
src _ dst ← ↓⍉↑' '(≠⊆⊢)¨¯2↓f
⎕← ≢∪⊃,/src{⍬≡i←⍸⍺⍷start:i⋄(⊂⍵){∊1⌽⍵,⊂⍺}¨(≢⍺){((⍵+⍺)↓start)(⍵↑start)}¨i}¨dst

⍝ using formula from https://www.reddit.com/comments/3xflz8//cy4etju
elements ← +/start∊⎕A
rnar ← +/∊'Rn' 'Ar'⍷¨⊂start
ys ← 2×+/'Y'=start
⎕← elements - rnar + 1 + ys
