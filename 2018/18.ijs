NB. solving this one in 2020

n =: '.|#' i. 'm'fread'18.txt'

OG =: 2 < 1 +/@:= ;@]
TR =: 2 >:@< 2 +/@:= ;@]
LY =: 0 1 +:@*/@:< 1 2 +/"1@(=/) ;@]

next =: OG`TR`LY@.((<1 1) { ]) ]

step =: (1 3,.1 3) (next;._3) 0,~0, 0,.],.0:

*/ +/"1 (1 2) =/ ; step^:10 n           NB. part 1

*/ +/"1 (1 2) =/ ; step^:1e9 n          NB. part 2 (slow...)