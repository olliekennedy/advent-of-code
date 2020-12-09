input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i)

def check(pre, input)
  input.each_with_index do |x, i|
    next if i < pre + 1
    perms = (((i-1)-pre)..(i-1)).map {|y| input[y]}.permutation(2).to_a
    nada = true
    perms.each { |y| nada = false if y.sum == x }
    return x if nada
  end
end

puts check(5, input)
