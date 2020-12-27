load 'aoc.ijs'

n =: cutpara in'06'             NB. load
i =: dyad : '(>x) -. (>x) -. >y'
ws =: LF,' '

+/ (ws #@-.~ ~.) &> n           NB. part 1
+/ (ws #@-.~ >@(i/)@cut) &> n   NB. part 2