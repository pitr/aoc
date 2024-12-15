G ← ↑⊃⎕NGET'in/12.txt'1

⍝ adjacency vector
a ← ,G{(G=⍺)/¨⍵}⍥(⊢,¨{⊂(,⍵)/⍨9⍴⍳2}⌺3 3) (⍴G)⍴p←⍳⍴,G
⍝ build parent vector using union-find
m ← {p[⍵]}⍣≡p⊣ 2{p[⍵]←⍺}⍥({p[⍵]}⍣≡)/¨a

C ← (3 0 1)(1 2 5)(5 8 7)(7 6 3)
area ← {≢⍵}⌸m
peri ← m{+/⍵}⌸5-≢¨a
side ← m{+/⍵}⌸,{+/0 2 5∊⍨2⊥¨⍵[1;1]=C{⍵[⍺]}¨⊂,⍵}⌺3 3⊢(⍴G)⍴1+m

⎕← area+.×peri
⎕← area+.×side
