'span' 'stpath' 'pmat'⎕CY'dfns'

map ← ↑{('#.',⎕D)⍳⍵}¨⊃⎕NGET'in/24.txt'1

⍝ graph from map
flat ← ,map
graph ← ,{
    0=⊃⊃⍵[1;1]: ⊂⍬
    nei←(,3 3⍴⍳2)/,⍵
    ⊂1⊃¨(×⊃¨nei)/nei
}⌺3 3⊢map,¨(⍴map)⍴⍳≢flat

⍝ indices of locations, ensuring 0 is the first one
marks ← (flat⍳2),⍸flat>2

⍝ shortest path between each location
costs ← ↑{≢¨1↓¨(graph span ⍵)∘stpath¨marks}¨marks

⍝ distance of the shortest path
shortest ← {⌊/+/costs[2,/⍵]}

⎕← shortest 0,(1+pmat (≢marks)-1)
⎕← shortest 0,(1+pmat (≢marks)-1),0
