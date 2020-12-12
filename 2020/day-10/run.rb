input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i).sort
puts input.inspect

outlet = 0
one = 0
two = 0
three = 1
input.each do |x|
  case x - outlet
  when 1
    one += 1
  when 2
    two += 1
  when 3
    three += 1
  end
  outlet = x
end

puts one * three
