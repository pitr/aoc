load 'aoc.ijs'

s =: ".{. 't b' =: ];._2 in'13'             NB. load
b =: 0 -.~ a =: ,".;._1 ',',b               NB. load times (with and without x's)

t =: b(| -) s                               NB. bus times modulo start time
*/ ((i. <./) t) { b,.t                      NB. part 1

NB. Chinese Remainder calculator from
NB. https://code.jsoftware.com/wiki/Essays/Chinese_Remainder_Theorem
g0    =: , ,. =@i.@2:
it    =: {: ,: {. - {: * <.@%&{./
gcd   =: (}.@{.) @ (it^:(*@{.@{:)^:_) @ g0

assert=: 3 : 'assert. y'
ab    =: |.@(gcd/ * [ % +./)@(,&{.)
cr1   =: [: |/\ *.&{. , ,&{: +/ .* ab
chkc  =: [: assert ,&{: -: ,&{. | {:@cr1
cr    =: cr1 [ chkc


{: cr/ x:(* # ] ,. ] | ] - i.@#) a          NB. part 2 - format into mb pairs