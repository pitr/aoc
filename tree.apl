:Namespace T
    I ← {⍺[⍵]}

    ⍝ parent → depth order
    p2do ← { d(⍋p{⊂⌽⍵↑⍺}⍤¯1⊢d+1)⊣{z⊣d+←⍵≠z←⍺[⍵]⊣p,←⍵}⍣≡⍨⍵⊣d←⍵≠,p←⍪⍳≢⍵ }

    ⍝ depth → parent
    d2p ← { p⊣2{p[⍵]←⍺[⍺⍸⍵]}/{⊂⍵}⌸⍵⊣p←⍳⍴⍵ }

    ⍝ (m ∇ p) :: select sub-tree and compress
    del ← { {⍵-1+(⍸~m)⍸⍵}⍵/⍨m←⍺ }

    ⍝ (N ∇ p) :: reorient with new root N
    re ← { q⊣2{q[⍵,⍨(⍸p=⍵)~⍺]←⍺}/ {⍵=p[⍵]:⍵ ⋄ ⍵,∇p[⍵]} ⍺⊣q←⍺@⍺⊢p←⍵ }

    ⍝ given json, get depth key values types
    ⍝ d k v t ← ↓⍉⎕JSON⎕OPT'Format' 'M'⊢j
    ⍝ types←'N/A' 'Object' 'Array' 'Numeric' 'String'

    ⍝ reverse
    ⍝ ⎕JSON⎕OPT('Format' 'M')('Compact' 0)⍉↑d k v t

    _PrettyPrint_←{ ⍝ renders a tree given labels, box drawing characters, and padding
        ⍝ ←: vector of character matrices, each a labelled rendering of a tree in the forest given by the input parent vector
        labels    ←⍺     ⍝ vector of character matrices giving the labels for each node
        connectors←⍺⍺    ⍝ box drawing characters to render the tree, e.g: '─┌┬┐│┴├┼┤│' (normal, and upstruck)
        spaces    ←⍵⍵    ⍝ number of spaces to pad with between sub-trees
        p         ←⍵     ⍝ parent vector
        d _←p2do p
        maxDepth←⌈/d
        results←labels         ⍝ result of rendering each sub-tree, seeded with labels
        maxDepth=0: results    ⍝ avoid the each running on the prototype
        DoFamily←{ ⍝ render and record a sub-tree
            ⍝ ⍺: parent node
            ⍝ ⍵: rendered results of children
            widths←(1⊃⍴)¨⍵                                                                           ⍝ widths of each rendered child
            width←spaces-⍨+/spaces+widths                                                            ⍝ eventual width of the rendered tree       wwwwwww
            centres←(+\0,¯1↓spaces+widths)+¯1+⌈2÷⍨widths                                             ⍝ centres of each rendered sub-tree         ∘ss∘ss∘
            result←width⍴' '                                                                         ⍝ header to be decorated                   '       '
            result[(⊢⊢⍤/⍨((⊃⌽centres)>⊢)∧(⊃centres)<⊢)⍳width]←connectors[0]                          ⍝ add horizontal bar                       ' ───── '
            result[   ⊃ centres]←connectors[1]                                                       ⍝ left end of bar                          '┌───── '
            result[   ⊃⌽centres]←connectors[3]                                                       ⍝ right end of bar                         '┌─────┐'
            result[¯1↓1↓centres]←connectors[2]                                                       ⍝ connectors to intermediate children      '┌──┬──┐'
            result[(1=≢centres)⍴⊃centres]←connectors[4]                                              ⍝ if there's only one child, just make it a lone upstrike
            centre←¯1+⌈2÷⍨width                                                                      ⍝ index of the centre of the rendered tree     ∘
            result[centre]←connectors[5 6 7 8 9][connectors[0 1 2 3 4]⍳result[centre]]               ⍝ connector to the parent                  '┌──┼──┐'
            result⍪←(-spaces)↓⍤1⊃,/,∘(spaces⍴' ')⍤1¨⍵↑¨⍨⌈/≢¨⍵                                        ⍝ pad labels, join under header
            parentResult←⍺⊃results                                                                   ⍝ label of the parent
            parentWidth←1⊃⍴parentResult                                                              ⍝ width of label of parent
            parentCentre←¯1+⌈2÷⍨parentWidth                                                          ⍝ centre of label of parent
            result      ←((centre-parentCentre)⌽parentWidth↑⍤1⊢)⍣(width<parentWidth)⊢result          ⍝ pad and recentre text so far if it's less wide
            parentResult←((parentCentre-centre)⌽      width↑⍤1⊢)⍣(width>parentWidth)⊢parentResult    ⍝ pad and recentre parent label if it's less wide
            result⍪⍨←parentResult                                                                    ⍝ add parent label
            results[⍺]←⊂result                                                                       ⍝ record result
            1
        }
        DoLayer←{ ⍝ render and record all nodes whose children have depth ⍵
            ⍝ ⍵: depth to handle nodes at
            i←⍸d=⍵    ⍝ nodes at this depth
            _←p[i]DoFamily⌸results[i]
            1
        }
        _←DoLayer¨⌽1+⍳maxDepth    ⍝ bottom up accumulation
        results/⍨p=⍳≢p            ⍝ return results at roots only
    }

    PPV←{⍺←⍳⍴⍵ ⋄   ((≢⍵)⍴⍉⍤⍪⍤⍕¨'∘'@(0=≢¨)⍺)('─┌┬┐│┴├┼┤│'_PrettyPrint_ 1)⍵}
    PPH←{⍺←⍳⍴⍵ ⋄ ⍉¨((≢⍵)⍴  ⍪⍤⍕¨'∘'@(0=≢¨)⍺)('│┌├└─┤┬┼┴─'_PrettyPrint_ 0)⍵}

:EndNamespace
