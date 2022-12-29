map ← ↑⊃⎕NGET'in/19e.txt'1
path ← ''
1 0{' '=c←⍵⌷map: ⋄ path,←c ⋄ turn←'+'=c ⋄ dir←turn⌽⍺ ⋄ dir×←1-2×turn∧' '=(⍵+dir)⌷map ⋄ dir∇⍵+dir} 0,map[0;]⍳'|'

⎕← path~'|-+'
⎕← ≢path
