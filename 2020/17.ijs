load 'aoc.ijs'

n =: (, $~ 1 , $) '#'='m'in'17'                 NB. load

wrap =: 0,~0,0,.~0,.0,"1~ 0,"1 ]                NB. wrap array
M =: 1(<4 1)}1(3)}82 2$0                        NB. lookup matrix
next =: M {~ +/@, <@, ] {~ <@:*@$               NB. compute for 3x3x3.. matrix
step =: (3 $~ #@$) (next;._3) wrap&wrap         NB. split into 3x3x3..

+/, step^:6 n                                   NB. part 1

wrap =: 0,~0, 0,.~0,. 0,"2~ 0(,"2) 0,"1~ 0,"1 ] NB. wrap for 4-rank array

+/, step^:6 ,: n                                NB. part 2