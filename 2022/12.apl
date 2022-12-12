'stpath' 'span'⎕CY'dfns'

a S E ← 0 ¯1 1 + ⎕UCS'aaz'
map ← S@(=∘(⎕UCS'S')) E@(=∘(⎕UCS'E')) ⎕UCS↑ ⊃⎕NGET'in/12.txt'1
flat ← ,map

graph ← ,{
    ele ← ⊃⊃⍵[1;1]
    nei ← ,⍵×3 3⍴⍳2         ⍝ neighbors :: [(elevation,id)]
    ⊂ 1⊃¨ (ele≤1+⊃¨nei)/nei ⍝ ids of neighbors that can be visited
}⌺3 3⊢map,¨ (⍴map)⍴⍳≢flat

tree ← graph span flat⍳E    ⍝ span tree trom "E"

⍝ using http://dfns.dyalog.com/n_stpath.htm
steps ← { ⌊/ ({≢ 1↓ tree stpath ⍵}¨ ⍸flat=⍵) ~ 0 }

⎕← steps S
⎕← steps a
