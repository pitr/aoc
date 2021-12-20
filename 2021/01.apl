n ← ⍎¨ ⊃⎕NGET'in/01.txt'1

+/ 2</n     	⍝ part 1: count increases
+/ 2</ 3+/n 	⍝ part 2: count increases in 3-wise sums

(+/¨ ⊢< 1 3 ⌽¨ ⊢) ⊂ n   ⍝ OR solve both at the same time
