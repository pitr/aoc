require './vm'
require 'set'

def day23_1(inp)
  queue = Array.new(50) { [] }
  vms = Array.new(50) { |i| vm = VM.new(inp); vm.run_to_consume([i]); vm }
  loop do
    vms.each_with_index.map do |vm,i|
      result = vm.run_to_end(queue[i].shift || [-1])
      result.each_slice(3) do |(i,x,y)|
        if i == 255
          puts y
          return
        end
        queue[i] << [x,y]
      end
    end
  end
end

day23_1(File.read('in/23.txt'))

def day23_2(inp)
  queue = Array.new(50) { [] }
  vms = Array.new(50) { |i| vm = VM.new(inp); vm.run_to_consume([i]); vm }
  nat = []
  nat_seen = Set.new
  loop do
    vms.each_with_index.map do |vm,i|
      result = vm.run_to_end(queue[i].shift || [-1])
      result.each_slice(3) do |(i,x,y)|
        case i
        when 255
          nat = [x,y]
        when 0..49
          queue[i] << [x,y]
        else raise "unknown address #{i}"
        end
      end
    end
    total_queue = queue.map(&:size).sum
    if total_queue == 0
      if nat.empty?
        raise "nat has nothing to send to idle network"
      else
        if nat_seen.include?(nat.last)
          puts nat.last
          return
        else
          nat_seen << nat.last
          queue[0] << nat.dup
          nat = []
        end
      end
    end
  end
end

day23_2(File.read('in/23.txt'))
