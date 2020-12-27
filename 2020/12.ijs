load 'aoc.ijs'

n =: |. (".@}. ,~ 'NSEWLRF' i. {.)&>'b'in'12'      NB. load

NB. NSEWLRF ::: use value of x (op,val) to mutate y (pos,dir)
N =: ] + 0 ,~ 0j1 * {:@[
S =: ] + 0 ,~ 0j_1 * {:@[
E =: ] + 0 ,~ 1 * {:@[
W =: ] + 0 ,~ _1 * {:@[
L =: ] * 1 , 0j1 ^ 90 %~ {:@[
R =: ] * 1 , 0j_1 ^ 90 %~ {:@[
F =: ] + 0 ,~ {:@] * {:@[

do =: N`S`E`W`L`R`F
run =: do@.({.@[)/@,
+/ (**) +. {. n run 0 1                 NB. part 1 - sum of abs of real/imag of pos

NB. re-declare for part 2
N =: ] + 0 , 0j1 * {:@[
S =: ] + 0 , 0j_1 * {:@[
E =: ] + 0 , 1 * {:@[
W =: ] + 0 , _1 * {:@[

+/ (**) +. {. n run 0 10j1              NB. part 2 - sum of abs of real/imag of pos