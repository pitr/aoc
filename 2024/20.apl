w ← ⊃⌽⍴g ← ↑⊃⎕NGET'in/20.txt'1
g ← ,g ⋄ p1 ← 100 ⋄ p2 ← 100 ⍝ ⋄ p1 ← 2 ⋄ p2 ← 50
p ← {⍵∪n/⍨'#'≠g[n←w¯1(-w)1+⊢/⍵]}⍣≡g⍳'S'
d ← ⊃+/(|∘.-⍨)¨↓⍉↑⍸w w⍴1@p⊢0⊣¨g
s ← ∘.-⍨⍋p
⎕← +/∊(2=d)∧p1≤s-d
⎕← +/∊(21>d)∧p2≤s-d
