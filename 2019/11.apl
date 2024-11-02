N ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/11.txt'1

vm ← ⎕FIX'vm.apl'

run ← {
    pos dir ← ⍵
    m∘← m vm.resume⍨ pos∊⍺
    seen,←pos
    0=⊃m: ⍺
    col turn ← 3⊃m
    dir←turn⊃dir(×,÷)0j1
    col: (⍺,pos)∇(pos+dir),dir
    (⍺~pos)∇(pos+dir),dir
}

seen ← ⍬

m ← vm.run N
_ ← ⍬ run 0 ¯1

⎕← ≢∪seen

m ← vm.run N
p ← 0 run 0 ¯1

p-← ⌊/p←↓⍉9 11∘.○p
⎕← ' #'[1@p⊢0⍴⍨1+⊃⌈/p]
