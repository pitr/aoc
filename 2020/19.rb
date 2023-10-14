rls, input = File.read("in/19.txt").split("\n\n")

rls = rls.lines.map do |line|
    line = line.chomp.gsub(': ', '=>[[') + ']]'
    line.gsub(' | ', '],[').gsub(' ', ',')
end.join(',')

$rules = eval("{ #{rls} }")

def mkregex
    Hash.new do |h,k|
        rule = $rules[k].map { |subrule|
          subrule.map { |subsubrule|
            String === subsubrule ? subsubrule : h[subsubrule]
          }.join
        }.then { |res| res.length == 1 ? res.first : "(#{res.join('|')})" }

        h[k] = rule
    end
end

rls = mkregex

regex = Regexp.new("^#{rls[0]}$")

p input.lines.grep(regex).count


rls = mkregex
rls[8] = "(#{rls[42]})+"
rls[11] = "(?<r>#{rls[42]}\\g<r>?#{rls[31]})"

regex = Regexp.new("^#{rls[0]}$")

p input.lines.grep(regex).count