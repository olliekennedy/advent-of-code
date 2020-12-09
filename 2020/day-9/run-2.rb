input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i)
# puts input.inspect

def check(preamble, input)
  first_error = nil
  input.each_with_index do |x, i|
    if i < preamble + 1
      next
    end
    pre = (((i-1)-preamble)..(i-1)).map {|y| input[y]}
    perms = pre.permutation(2).to_a
    tally = 0
    perms.each do |y|
      if y[0]+y[1] == x
        tally += 1
      end
    end
    if tally == 0
      return x
    end
  end
end

def find_contig(input)
  err = check(25, input)
  n = 1
  pos = 0
  found = []
  while pos < input.length do
    test = input.slice(pos,n)
    sum = test.sum
    if sum == err
      found = test
      break
    elsif n > err || n + pos > input.length || sum > err
      n = 1
      pos += 1
      next
    end
    n += 1
  end
  return found.min + found.max
end


puts find_contig(input)
