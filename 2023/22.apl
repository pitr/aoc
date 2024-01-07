X Y Z ← ↓↓1 2 0⍉ ↑2 3∘⍴¨ {⍵[⍋2⊃¨⍵]} (⍎¨∊∘⎕D⊆⊢)¨⊃⎕NGET'in/22.txt'1
to ← ⊃+(⍳1--/)
pos ← X(,∘.,⍥to)¨Y  ⍝ X,Y positions for each brick
drop ← {
    ⍺ ← ¯1 ⋄ skip ← ⍺ ⋄ peaks ← 10 10⍴0
    (⍳≢⍵){ ⍺=skip: ⍵ ⋄ n⊣peaks[⍺⊃pos] ← ⊢/n←⍵-dz←0⌈⍵[0]-1+⌈/peaks[⍺⊃pos] }¨⍵
}
falls ← {+/Z≢¨⍵ drop Z}¨⍳≢Z ← drop Z
⎕← +/falls=0
⎕← +/falls
