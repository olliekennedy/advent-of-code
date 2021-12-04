input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split("") }#.map(&:to_i)
length = input[0].length
puts length/2
puts input.inspect

gamma = []

(0..length-1).each do |x|
  zero_count = 0

  input.each do |y|

    zero_count+=1 if y[x] == "0"

  end
  puts zero_count
  if zero_count > input.length / 2
    gamma << "0"
  else
    gamma << "1"
  end
  zero_count = 0
end

epsilon = gamma.map{ |x| x == "0" ? "1" : "0" }

g = gamma.join("").to_i(2)
e = epsilon.join("").to_i(2)

puts "gamma = #{g}"
puts "epsilon = #{e}"
puts "answer = #{g*e}"