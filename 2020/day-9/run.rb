input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i)
# puts input.inspect

def check(preamble, input)
  first_error = nil
  input.each_with_index do |x, i|
    if i < preamble + 1
      next
    end
    pre = (((i-1)-preamble)..(i-1)).map {|y| input[y]}
    perms = pre.permutation(2).to_a
    # puts pre.inspect
    tally = 0
    # puts x
    perms.each do |y|
      if y[0]+y[1] == x
        # puts "#{y[0]} + #{y[1]} == #{x}"
        tally += 1
      end
    end
    # puts "tally = #{tally}"
    if tally == 0
      return x
    end
  end
end


puts check(5, input)
