N ← ⊃⊃⎕NGET'in/05.txt'1

⍝ (pc mode) arg ← get mode for arg
mode ← { ⊃((⍵+2)⍴10)⊤n[⍺⍺] }
⍝ (pc get) arg ← get arg at pc
get  ← { m←(⍺⍺mode) ⍵ ⋄ 0=m: n[n[⍺⍺+⍵]]   ⋄ 1=m: n[⍺⍺+⍵] }
⍝ arg (pc set) val ← set arg at pc to val
set  ← { m←(⍺⍺mode) ⍺ ⋄ 0=m: n[n[⍺⍺+⍺]]←⍵ ⋄ 1=m: panic }

math ← { ⍵+4⊣ 3 (⍵set) ⍺⍺/(⍵get)¨1 2 }
jump ← { (⍵+3)((⍵get)2)[0 ⍺⍺ (⍵get)1] }
cmp  ← { ⍵+4⊣3(⍵set) ⍺⍺/(⍵get)¨1 2 }

step ← {
    op←100|z←n[⍵]
    ⍝⎕← (1 4 4 2 2 3 3 4 4[99|op])↑⍵↓n
    1=op: +math ⍵
    2=op: ×math ⍵
    3=op: ⍵+2⊣ inp∘←1↓inp⊣ 1(⍵set)⊃inp
    4=op: ⍵+2⊣ out,←(⍵get) 1
    5=op: ≠jump ⍵
    6=op: =jump ⍵
    7=op: <cmp ⍵
    8=op: =cmp ⍵
    99=op: ⍵
    ⎕←'op='op
    fail
}
run ← { ⍺←⍬ ⋄ n∘←⍎¨','(≠⊆⊢)⍵ ⋄ inp∘←⍺ ⋄ out∘←⍬ ⋄ out⊣step⍣≡0 }

⎕← 1 run N
⎕← 5 run N
