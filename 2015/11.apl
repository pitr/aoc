A ← ⎕C⎕A
bad ← A⍳'iol'
check ← {
    a ← ∨/1 1⍷-2-/⍵
    b ← ~∨/⍵∊bad
    c ← 2=/⍵
    ∧/a b (2≤+/c) (~∨/1 1⍷c)
}

sh ← 8/26
next ← { check sh⊤⍵: ⍵ ⋄ ∇⍵+1 }
n ← 26⊥A⍳ ⊃⊃⎕NGET'in/11.txt'1

⎕← A[sh⊤n←next 1+n]
⎕← A[sh⊤  next 1+n]
