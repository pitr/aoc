load 'aoc.ijs'

n =: 'L'='m'in'11'                                  NB. load

M =: 0,.2,1,.4 5 # 2 1                              NB. lookup matrix for part 1
next =: M {~ ([: +/ 2 = ,) <@, (<1 1) { ]           NB. compute 1s/2s for 3x3 matrix
step =: (3 3) (next;._3) 0,~0, 0,.],.0:             NB. split into 3x3, compute
+/2=, step^:_ n                                     NB. part 1



ob =: /: ; </. i. $ n                               NB. oblique indices

acc =: [`]@.(*@])                                   NB. 1 way accumulator for seats
lin =: (_1|.!.0 acc/\) +&(=&2) 1|.!.0 acc~/\.       NB. 2-way 2s for a row
vis =: lin"1 + $ $ ob { [: ; <@lin/.                NB. 2s for horizontals & obliques of matrix
D =: 5
next =: (0=])`(D>])@.(2=[)"0 vis&.|: + vis&.|.      NB. compute 2s for next iteration
step =: n*1 + next                                  NB. find 2s, mask with floors
+/2=, step^:_ n                                     NB. part 2