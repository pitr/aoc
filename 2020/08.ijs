load 'aoc.ijs'

'acc jmp nop'=:0 1 _1
C =: ((3 ".@{. ]) , 4 ".@}. ])&>'b'in'08'       NB. load

run =: 3 : 0"0
  'pc acc' =. 0 0
  visited =. (#C) $ 0

  while. 1 do.
    if.     pc >: #C do. break.
    elseif. pc{visited do. break.
    else. visited =. 1 pc}visited
          'op arg' =. pc { C
          if. pc=y do. op =. -op end.
          select. op
          case. _1 do. pc =. pc + 1
          case. 0 do. pc =. pc+1 [ acc =. acc + arg
          case. 1 do. pc =. pc+arg end.
    end.
  end.
  acc,pc=#C
)

{. run _                          NB. part 1

{. 3 : 0''                        NB. part 2
  for_i. I. -. 0= 0{"1 C do.      NB. select indices of jmps and nops
    'acc ok' =. run i
    if. {: run i do. break. end.
  end.
)