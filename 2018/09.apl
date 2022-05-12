players worth ← ⍎¨(∊∘⎕D⊆⊢)⊃⊃⎕NGET'in/09.txt'1

right ← {ring[⍵;1]}
left  ← {ring[⍵;0]}

insert ← {
    j ← right⊢i ← right ⍵
    cur  ← ring[(i 1)(j 0)]←≢ring
    ring⍪← i j
    cur
}

delete ← {
    i ← left⊢scores ,← left⊢ j ← left⍣6⊢⍵
    ring[(i 1)(j 0)] ← j i
    ring⍪← 0
    j
}

play ← { insert⍣(23|⍵) delete∘(insert⍣22)⍣(⌊⍵÷23)⊢0 }
max ← { totals  ← ⍵+marble ← 23×1+⍳≢⍵ ⋄ ⌈/{+/totals[⍵]}⌸players|marble}

scores ← ⍬ ⋄ ring ← 1 2⍴0 ⋄ max scores⊣play worth
scores ← ⍬ ⋄ ring ← 1 2⍴0 ⋄ max scores⊣play worth×100
