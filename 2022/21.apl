⎕CY'dfns'
f ← ⊃⎕NGET'in/21.txt'1
⍎¨ (','' '⎕R','')'' ')∘(' '','⎕R' ''('',')∘('← (.*)$'⎕R'← { ''\1'' }')∘(' ([a-z]{4})'⎕R' ,(\1 ⍵),')∘('[-+×÷]'⎕R' ''\0'' ')∘('/'⎕R'÷')∘('\*'⎕R'×')∘(':'⎕R' ←')¨f
⎕← ⍎root 0
humn←{'x'}
⎕← root     ⍝ paste result, replace sign with =, run and paste into https://www.mathpapa.com/simplify-calculator/
⎕← root 0
