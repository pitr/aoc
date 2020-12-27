def day2_1(inp)
  min,max=inp.split('-')
  def co(left,seen_dup,min,max)
    return 0 if left < min[0,left.length] || left > max[0,left.length]
    if left.length == 6
      return seen_dup ? 1 : 0
    end
    ?0.upto(?9).map { |n|
      case
      when left[-1]==n then co(left+n,true,min,max)
      when left[-1]<n then co(left+n,seen_dup,min,max)
      else 0
      end
    }.sum
  end
  min[0].upto(max[0]).map { |n| co(n,false,min,max) }.sum
end

day2_1("136760-595730")

def day2_2(inp)
  min,max=inp.split('-')
  def co(left,seen_dup,dup_count,min,max)
    return 0 if left < min[0,left.length] || left > max[0,left.length]
    if left.length == 6
      return seen_dup || dup_count==2 ? 1 : 0
    end
    ?0.upto(?9).map { |n|
      case
      when left[-1]==n then co(left+n,seen_dup,dup_count+1,min,max)
      when left[-1]<n then co(left+n,seen_dup||dup_count==2,1,min,max)
      else 0
      end
    }.sum
  end
  min[0].upto(max[0]).map { |n| co(n,false,1,min,max) }.sum
end

day2_2("136760-595730")
