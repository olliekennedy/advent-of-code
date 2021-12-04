input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i)
puts input.inspect

count = 0

input.each_with_index do |x, i|
  next if i == 0

  if x > input[i-1]
    count+=1
  end
end
puts count