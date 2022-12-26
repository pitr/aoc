/ part 1
d@:>d:(+/1_)'{(&^x)_x}`I$0:"in/01.txt"
*d
+/3#d

/ part 2
d:-"AX"-(+0:"in/02.txt")_1
+/ (1+d[1]) + 3*3!1--/d
+/ (3*d[1]) + 1+3!2++/d

/ part 3
r:58!20+0:"in/03.txt"
i:{?x^x^y}/
*+/i'2 0N#/:r
*+/i'0N 3#r

/ part 4
(al;ah;bl;bh):+,/'`I$"-"\''","\'0:"in/04.txt"
(≤): ~>
+/ ((al≤bl)&(bh≤ah)) | (bl≤al)&(ah≤bh)
+/ (al≤bh) & (bl≤ah)

/ part 6
s:1:"in/06.txt"
{x+*&x{x~?x}':s}'4 14

/ part 7
lines:0:"in/07.txt"
pwd:sz:!0
{$["$ cd .."~x;[sz,: *|pwd; pwd::-1_pwd]
   "$ cd "~5#x;pwd,:0
   ^"$d"?*x;pwd+:`I$*" "\x]}'lines;
sz,:pwd
+/(1e5>)#sz
&/{~x<|/sz-4e7}#sz

/ part 10
vals:+\1,(^:)_,/{0,.5_x}'0:"in/10.txt"
+/ {x*vals[x-1]} 20+40*!6
" #"2>|/-:\-/(6 40#)'(vals;!40)

/ part 11
f:5#'1_'0N 7#0:"in/11.txt"
(items;op;mod;true;false):+{(.*|": "\x 0 ; *|"= "\x 1),(.*|)'" "\'2_x}'f
eval:{old::y ; new:div!.op[x] ; pck[$[mod[x]!new ; false ; true][x]],:new}
step:{inspects[x]+:#x eval'pck[x] ; pck[x]:!0}
run:{inspects::&#pck::items ; div::x ; y {step'!#pck}/0 ; */inspects@2#>inspects}
run[-3;20]
run[*/mod; 10000]
