m ← ↑⊃⎕NGET'in/03.txt'1
dig ← m∊⎕D
sym ← ⍸ (m≠'.')-dig
num ← ⍎¨⊃,/(↓dig)⊆¨(↓m)
dir ← ∘.,⍨¯1+⍳3

d ← ⊃,/(⍳≢dig) {⍺,¨¨⍵⊆⍳≢⍵}¨ ↓dig
⎕← +/num/⍨∨⌿C←sym ∘.{1∊(dir+⊂⍺)∊⍵} d

S ← (∊m)~⎕D,'.'
⎕← +/{×/⍵/num}¨↓C⌿⍨('*'=S)∧2=+/C
