n ← {⍎¨⍵⊆⍨⍵∊⎕D}¨⊃⎕NGET'in/07.txt'1

clean ← {⍵/⍨⍵=0⌈⌊⍵}∪
valid ← {0∊⊃(clean⍺⍺)/1⌽⍵}
solve ← {+/⊃¨n/⍨⍺⍺valid¨⍵}
⎕← { (⍵~0)(-,÷)⍺                  } solve n
⎕← {((⍵~0)(-,÷)⍺),(⍵-⍺)÷10*1+⌊10⍟⍺} solve n
