load 'aoc.ijs'

n =: 'b'in'18'              NB. load

eval =: '())(' ".@|.@charsub ]
+/ eval &> n                NB. part 1 - eval reversed tokens (with brackets flipped)

NB. a/m ::: adds/multiplies, ensuring that + has higher precedence than *
a =: }.@] ,~ [ + {.@]
m =: ,

NB. simple ::: evaluates simple expression without parentheses
simple =: '+a*m' */@".@charsub ]

NB. level ::: finds, evaluates and replaces first complete sub-expression
level =: 3 : 0
  if. '('e.y do.
    end =. >: y i.')'       NB. find first closing bracket (end of first flat sub-expression)
    ss =. end {. y
    start =. ss i: '('      NB. start of that sub-expression
    (start&{. , (,8!:2 simple start }. ss) , end&}.) y
  else.
    y
  end.
)

eval =: x:@simple level^:_
+/ eval &> n                NB. part 2