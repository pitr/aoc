def day6_1(inp)
  pa={}
  inp.lines {|l| a,b=l.strip.split(')'); raise '2 parents' if pa[b];pa[b]=a}
  de=Hash.new { |de, n| pn = pa[n]; de[n] = pn ? de[pn]+1 : 0 }
  pa.keys.each{|n|de[n]}
  de.values.sum
end

day6_1("""COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L""")

day6_1(File.read('6.txt'))


def day6_2(inp)
  pa={}
  inp.lines {|l| a,b=l.strip.split(')'); raise '2 parents' if pa[b];pa[b]=a}
  de=Hash.new { |de, n| pn = pa[n]; de[n] = pn ? de[pn]+1 : 0 }
  def pas(n, pa)
    pa[n] ? [pa[n]] + pas(pa[n], pa) : []
  end
  pa.keys.each{|n|de[n]}
  cp = (pas('SAN', pa) & pas('YOU', pa)).first
  de['SAN'] + de['YOU'] -2 - de[cp] * 2
end

day6_2("""COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN""")

day6_2(File.read('6.txt'))
