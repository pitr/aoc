n ← ⍎¨⊃⎕NGET'in/02.txt'1

check ← {(1=≢∪×d)∧∧/1 2 3∊⍨|d←2-/⍵}¨

⎕← +/check n
⎕← +/{∨/check(↓∘.≠⍨⍳⍴⍵)/¨⊂⍵}¨n
