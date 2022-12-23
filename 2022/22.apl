f ← ⊃⎕NGET'in/22.txt'1
L R ← 0j1 0j¯1
steps ← ⍎¨ '(\d+|[LR])'⎕S'&' ⊃¯1↑f
map ← {⍉0,⍵,0}⍣2⊢' .#'⍳↑¯2↓f
dirs ← (0 1)(1 0)(0 ¯1)(¯1 0)

xy ← 1,map[1;]⍳1

⎕← xy 0 {
    xy dir ← ⍺
    step ← ⊃⍵
    0=≢⍵: +/1000 4 1×xy,dir
    L=step: xy (4|dir-1) ∇ 1↓⍵
    R=step: xy (4|dir+1) ∇ 1↓⍵
    0=step: ⍺ ∇ 1↓⍵
    dxy ← dir⊃dirs
    xy +← dxy
    1=xy⌷map: xy dir ∇ (step-1)@0⊢⍵
    2=xy⌷map: ⍺ ∇ 1↓⍵
    xy ← dxy+{⍵-dxy×0≠⍵⌷map}⍣≡xy-dxy
    2=xy⌷map: ⍺ ∇ 1↓⍵
    xy dir ∇ (step-1)@0⊢⍵
} steps

faces ← 4 4⍴⊂⍬
faces[0;1] ← ⊂(0 2)(1 1)(2 0)(3 0)
faces[0;2] ← ⊂(2 1)(1 1)(0 1)(3 0)
faces[1;1] ← ⊂(0 2)(2 1)(2 0)(0 1)
faces[2;1] ← ⊂(0 2)(3 0)(2 0)(1 1)
faces[2;0] ← ⊂(2 1)(3 0)(0 1)(1 1)
faces[3;0] ← ⊂(2 1)(0 2)(0 1)(2 0)

side ← .5*⍨ 6÷⍨ +/∊0≠map
edges ← (1 1)(1 side)(side side)(side 1)

xy ← 1,map[1;]⍳1

⎕← xy 0 {
    xy dir ← ⍺
    step ← ⊃⍵
    0=≢⍵: +/1000 4 1×xy,dir
    L=step: xy (4|dir-1) ∇ 1↓⍵
    R=step: xy (4|dir+1) ∇ 1↓⍵
    0=step: ⍺ ∇ 1↓⍵
    to ← xy+dir⊃dirs
    1=to⌷map: to dir ∇ (step-1)@0⊢⍵
    2=to⌷map: ⍺ ∇ 1↓⍵
    face ← ⌊side÷⍨xy-1
    offset ← {1+⍵}⍣{xy≡⊃+/(side×face) (edges⊃⍨4|dir+1) (⍺×dirs⊃⍨4|dir+1)}¯1
    nface ← dir⊃⊃face⌷faces
    ndir ← 4|2+(⊂face)⍳⍨⊃nface⌷faces
    to ← ⊃+/(side×nface) (ndir⊃edges) (offset×dirs⊃⍨4|ndir+1)
    2=to⌷map: ⍺ ∇ 1↓⍵
    to ndir ∇ (step-1)@0⊢⍵
} steps
