input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i)

def check(pre, input)
  input.each_with_index do |x, i|
    next if i < pre + 1
    perms = (((i-1)-pre)..(i-1)).map {|y| input[y]}.permutation(2).to_a
    nada = true
    perms.each { |y| nada = false if y.sum == x }
    return x if nada
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
    elsif sum > err
      n = 1
      pos += 1
      next
    end
    n += 1
  end
  return found.min + found.max
end

puts find_contig(input)
