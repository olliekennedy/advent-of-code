input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i).sort
# puts input.inspect

start = 0
input.unshift(start)

count = 0
posses = []
input.each do |x|
  poss = input.select { |y| y - x >= 1 && y - x <= 3}
  posses << poss
  puts poss.inspect
end

start = 0
i = 7
try = [input[i]]
while true do
  if input[i+1] - input[i] == 3
    break
  else
    try << input[i+1]
  end
  i += 1
end
puts try.inspect
perms = try.permutation.to_a.reduce{|prev,l| break unless l[0] >= prev[0]; l}

puts perms.inspect



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

# puts one * three
