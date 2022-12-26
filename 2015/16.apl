children←3∘= ⋄ samoyeds←2∘= ⋄ cars←2∘= akitas←0∘= ⋄ vizslas←0∘= ⋄ perfumes←1∘=
cats ← 7∘= ⋄ pomeranians ← 3∘= ⋄ goldfish ← 5∘= ⋄ trees ← 3∘=

f ← ↑{⊃¨{⍺,' ',⍵}/¨0 1 0 1 0 1 0⊂⍵}¨1↓¨' ,:'∘((~∊⍨)⊆⊢)¨⊃⎕NGET'in/16.txt'1
⎕← 1+⍸∧/⍎¨f

cats ← 7∘< ⋄ pomeranians ← 3∘> ⋄ goldfish ← 5∘> ⋄ trees ← 3∘<
⎕← 1+⍸∧/⍎¨f
