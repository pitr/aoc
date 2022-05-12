'trav'⎕CY'dfns'

asm ← ⌽⍎¨⊃⌽ f ← (⊢⊆⍨0≠≢¨)⊃⎕NGET'in/16.txt'1
checks ← {⍎¨@1(⍎¨∊∘⎕D⊆⊢)¨@0 2⊢⍵}¨¯1↓f

and ← (2⊥(∧/2⊥⍣¯1,))
or  ← (2⊥(∨/2⊥⍣¯1,))

run ← {
    op a b c ← ⍺
    op=0 :      (⍵[a]+⍵[b])@c⊢⍵ ⍝ addr
    op=1 :         (⍵[a]+b)@c⊢⍵ ⍝ addi
    op=2 :      (⍵[a]×⍵[b])@c⊢⍵ ⍝ mulr
    op=3 :         (⍵[a]×b)@c⊢⍵ ⍝ muli
    op=4 :  (⍵[a] and ⍵[b])@c⊢⍵ ⍝ banr
    op=5 :     (⍵[a] and b)@c⊢⍵ ⍝ bani
    op=6 :   (⍵[a] or ⍵[b])@c⊢⍵ ⍝ borr
    op=7 :      (⍵[a] or b)@c⊢⍵ ⍝ bori
    op=8 :           (⍵[a])@c⊢⍵ ⍝ setr
    op=9 :              (a)@c⊢⍵ ⍝ seti
    op=10:         (a>⍵[b])@c⊢⍵ ⍝ gtir
    op=11:         (⍵[a]>b)@c⊢⍵ ⍝ gtri
    op=12:      (⍵[a]>⍵[b])@c⊢⍵ ⍝ gtrr
    op=13:         (a=⍵[b])@c⊢⍵ ⍝ eqir
    op=14:         (⍵[a]=b)@c⊢⍵ ⍝ eqri
    op=15:      (⍵[a]=⍵[b])@c⊢⍵ ⍝ eqrr
}

⍝ part 1
+/3≤+/ checks ∘.{(2⊃⍺)≡(⍵@0⊢1⊃⍺) run 0⊃⍺} ⍳16

sorted ← ⍋≢¨possibilites ← ⊃{
    before inst after ← ⍺
    options ← ⊃⍵[op ← ⊃1⊃⍺]
    (⊂options/⍨{after≡(⍵@0⊢inst) run before}¨options)@op⊢⍵
}/checks,⊂16⍴⊂⍳16

next ← {16=≢⍵: ⍬ ⋄ (⊂⍵) ,¨ (⊃possibilites[sorted[≢⍵]]) ~ ⍵}

solution ← {⍵[⍋sorted]} ⊃⍬ {⍺,(16=≢⍵)↑⊂⍵} trav next ⍬

⍝ part 2
⊃⊃{(solution[⊃⍺]@0⊢⍺) run ⍵}/asm,⊂4⍴0
