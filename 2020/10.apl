n ← ⍎¨⊃⎕NGET'in/10.txt'1

⎕← ×/+/1 3∘.=n←3,2-/n[⍒n],0

tri ← 1 1 2 4 7 13 24       ⍝ first few tribonacci numbers
⎕← ×/tri[≢¨n⊆⍨1=n]
