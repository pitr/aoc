N ← ⍎⊃⊃⎕NGET'in/02.txt'1

step ← {1=op←n[⍵]: ⍵+4⊣n[n[⍵+3]]←+/n[n[⍵+1 2]] ⋄ 2=op: ⍵+4⊣n[n[⍵+3]]←×/n[n[⍵+1 2]] ⋄ 99=op: ⍵ }
run ← { n∘←N ⋄ n[1 2] ← ⍺⍵ ⋄ 0⊃n⊣step⍣≡0 }

⎕← 12 run 2
⎕← 100⊥⊃⍸19690720= ∘.run⍨ ⍳99
