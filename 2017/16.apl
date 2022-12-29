start ← word ← 16↑⎕C⎕A
s ← {word ⌽⍨← -⍵} ⋄ x ← {word[⌽⍵]←word[⍵]} ⋄ p ← {word[word⍳⍵]←⌽⍵}
hist ← 0 16⍴' '
code ← {¯1⌽' ',1⌽⍵}¨','(≠⊆⊢)'([a-z])/([a-z])' '/'⎕R'''\1\2''' ' '⊃⊃⎕NGET'in/16.txt'1
{hist⍪←word ⋄ start≡word⊣⍎¨code: 0 ⋄ ∇hist} ⍬

⎕← hist[1;]
⎕← hist[(≢hist)|1e9;]
