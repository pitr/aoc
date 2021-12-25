⎕PP←17

f ← {(⍵[1]='n'),1∘+@1¨↓3 2⍴⍎¨('-',⎕D)(∊⍨⊆⊢)⍵}¨⊃⎕NGET'in/22.txt'1

∆ ← ⊃{⍺+⍳⍵-⍺}/

vol ← {
    cu ← {∪{⍵[⍋⍵]}∊⍵}¨1↓↓⍉↑⍵    ⍝ possible cuboid coordinates
    m ← (¯1+≢¨cu)⍴0             ⍝ initialize empty cuboid map

    _←{ x y z ← cu ⍳¨ 1↓⍵       ⍝ get intersecting cuboids
        ⊃m[∆ x;∆ y;∆ z] ← ⊃⍵    ⍝ update cuboids with on/off
    }¨⍵                         ⍝ for each line

    +.×/⌽ (⊂m), 2-⍨/¨cu         ⍝ calculate volume
}

vol f/⍨(50≥⌈/⍤|⍤∊)¨f
vol f
