N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/15.txt'1

vm ← ⎕FIX'vm.apl'

m ← vm.run N

dir ← ¯1 1 0J1 0J¯1
H2O ← map ← 0

step ← {
    m ← ⍺
    depth pos ← ⍵
    d ← (1+⍳4)/⍨~(pos+dir)∊map
    0=≢d: ⍬
    ∊{
        m ← ⍵vm.resume m
        s ← 3⊃m
        0=s: ⍬
        map∪← pos
        2=s: depth+1⊣H2O∘←pos
        nxt ← pos+dir[⊃⍵-1]
        m step (depth+1)(nxt)
    }¨d
}

⎕← m step 0 0

count ← 1
⎕← count⊣{map∩⍵,∊dir∘.+⍵⊣count+←1}⍣≡H2O
