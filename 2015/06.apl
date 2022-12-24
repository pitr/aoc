to ← {⍺+⍳1+⍵-⍺}

lines ← (('nf '⍳6∘⌷),(⍎¨∊∘⎕D⊆⊢))¨⊃⎕NGET'in/06.txt'1
shape ← 1+ ⌈⌿2 2⍴⌈⌿↑1↓¨lines

run ← {
    map ← ⍵
    _← ⍺⍺{
        x ← ⊃to/⍵[1 3] ⋄ y ← ⊃to/⍵[2 4]
        ⊢map[x;y] ← (⊃⍵) ⍺⍺ map[x;y]
    }¨lines
    +/∊map
}

⎕← {⍺=0: 1 ⋄ ⍺=1: 0 ⋄ ⍺=2: ~⍵} run shape⍴0
⎕← {⍺=0: ⍵+1 ⋄ ⍺=1: 0⌈⍵-1 ⋄ ⍺=2: ⍵+2} run shape⍴0
