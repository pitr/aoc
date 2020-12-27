load 'aoc.ijs'

m =: ".'m'in'01'         NB. parse
*/m#~m e.2020-m          NB. part 1
*/m#~+./(+/~m)e.2020-m   NB. part 2

NB. Learnings
NB. fread  read file (if a is b/m then)
NB. cutLF  lines
NB. x e.y  x in y
NB. ".     eval (". '42' => 42)
NB. #~     swap a b and tally b#a (1 0 1 # 9 42 77 => 9 77)
NB. ~.     uniq