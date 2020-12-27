load 'aoc.ijs'

'x y' =: ".>0 2{'x d y c w' =: |:;:'m'in'02'    NB. parse
+/(x&<:*.y&>:)+/"1 w={."1 c                     NB. part 1
+/~:/"1(<:x,.y){"1 w={."1 c                     NB. part 2

NB. Learnings
NB. ;:a       split by words
NB. |:a       transpose
NB. a{b       lookup (0  2 { 42+i.5 => 42 44)
NB. 'x y'=:z  split rows into vars
NB. {.a       head
NB. {."1 a    head each
NB. a<:b      a <= b
NB. a*.b      and
NB. a,.b      join columns
NB. <:a       decrement
NB. a~:b      not equal