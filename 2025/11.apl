f ← ' :'∘((~∊⍨)⊆⊢)¨⊃⎕NGET'in/11.txt'1
n ← ∪⊃,/f
g ← 0×∘.≡⍨n
{}{g[⊃n⍳⍵;1↓n⍳⍵]←1}¨f
paths ← {⍺⍵⌷+.×⍨⍣≡1@(⊂⍵ ⍵)⊢g}/n⍳1 0 0 1⊂⊢
⎕ ← paths 'youout'
⎕ ← +/×/paths¨↑('svrfft' 'fftdac' 'dacout'
                'svrdac' 'dacfft' 'fftout')
