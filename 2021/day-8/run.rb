input = File.readlines('./test-input2.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split(" | ").map{ |y| y.split(" ") } }
puts input.inspect

count = 0
input.each do |x|
  output_value = x[1].dup
  output_value.each do |y|
    count += 1 if [2, 4, 3, 7].include?(y.length)
  end
end
puts count