'bsearch' 'mean'⎕CY'dfns'

n ← ⍎¨','(≠⊆⊢)⊃⊃⎕NGET'in/07.txt'1

tri ← { (⍵ × ⍵+1)÷2 }       ⍝ Triangular number, 1+2+..+⍵
median ← { ⍵[⍋⍵][⌊.5×≢⍵] }

⍝ First solution, O(n×m)

dx ← | n ∘.- ⍳⌈/n

⌊/ +⌿ dx
⌊/ +⌿ tri dx

⍝ Second solution using binary search, O(n×log(m))

+/     | n- { </ {+/     | n-⍵}¨ ⍵+⍳2 } bsearch 0,⌈/n
+/ tri | n- { </ {+/ tri | n-⍵}¨ ⍵+⍳2 } bsearch 0,⌈/n

⍝ Third solution using median/mean, O(n×log(n)) and O(n)

+/ | n - median n
⌊/ { +/ tri | n-⍵ }¨ (⌈,⌊) mean n

⍝ Reasoning on why mean is CLOSE to the optimal solution for part 2

⍝ Paper with proof that dx is within mean +/- 0.5
⍝ https://www.reddit.com/r/adventofcode/comments/rawxad/2021_day_7_part_2_i_wrote_a_paper_on_todays/

)off
                            ⍝ find dx such that the fuel use is lowest.
+/ { +/1+⍳⍵ }¨ |n-dx        ⍝ by definition of the puzzle.
+/ { .5 × ⍵ × ⍵+1 }¨ |n-dx  ⍝ replace 1+2+..+⍵ with a triangular formula.
+/ { ⍵ × ⍵+1 }¨ |n-dx       ⍝ remove constant multiplies as it doesn't impact optimal dx.
+/ { ⍵ + ⍵*2 }¨ |n-dx       ⍝ simplify using w × w+1 ≡ w+w*2.
+/ (|n-dx) + (|n-dx)*2      ⍝ move |n-dx inside each.
+/ (|n-dx) + (n-dx)*2       ⍝ remove modulo inside squared value.
(+/|n-dx) + +/(n-dx)*2      ⍝ split +/ since +/(a+b) ≡ (/a) + +/b
                            ⍝ lhs - (+/|n-dx) - is lowest when dx is median, by its properties.
                            ⍝ rhs - +/(n-dx)*2 - is lowest when dx is mean, by its properties.
                            ⍝ rhs is squared and is much more significant than lhs.
