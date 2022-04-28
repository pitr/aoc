'wpath' 'wcost'⎕CY'dfns'

m ← ⍎¨↑⊃⎕NGET'in/15.txt'1

risk ← { ⍝ using http://dfns.dyalog.com/n_wGraphs.htm
    w ← ,⍵
    edges ← ,{⊂ ¯1+ 0~⍨ ,⍵×3 3⍴⍳2}⌺3 3⊢1+(⍴⍵)⍴⍳≢w
    costs ← {w[⍵]}¨edges
    graph ← ↑edges costs
    +/graph wcost graph wpath 0,(≢w)-1
}

risk m
risk 10|{⍵+⍵>9} ⊃⍪/,/(+/¨⍳5 5)+5 5⍴⊂m
