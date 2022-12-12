'stpath' 'span'⎕CY'dfns'

map ← 96@(83∘=)⊢123@(69∘=)⊢ ⎕UCS↑ ⊃⎕NGET'in/12.txt'1

flat ← ,map
graph ← ,{
    el  ← ⊃⊃⍵[1;1]
    nei ← (⊂0 0)~⍨ ,⍵×3 3⍴⍳2
    ⊂ ¯1+1⊃¨nei/⍨el≤1+⊃¨nei
}⌺3 3⊢map,¨ 1+(⍴map)⍴⍳≢flat

tree ← graph span flat⍳123  ⍝ span tree trom "E"

⍝ using http://dfns.dyalog.com/n_stpath.htm
steps ← { ¯1+ ⌊/ 0~⍨ ≢¨ tree∘stpath¨ ⍸flat=⍵ }

⎕← steps 96 ⍝ to "S"
⎕← steps 97 ⍝ to "a"
