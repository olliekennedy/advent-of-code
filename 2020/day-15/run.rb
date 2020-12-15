input = File.read('./input.txt').split(",").map(&:to_i)
puts input.inspect

while input.length < 2020
  pot = input[0..-2].rindex(input[-1])
  if !pot.nil?
    input << (input.length - 1) - pot
  else
    input << 0
  end
end

puts input[-1]
