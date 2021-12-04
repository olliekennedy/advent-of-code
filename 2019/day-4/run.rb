input = '128392-643281'.split("-")#.map(&:to_i)
puts input.inspect


total = 0
(input[0]..input[1]).each do |x|
  numbers = {}
  x.split("").each do |y|
    numbers[y] = 0 unless numbers.include?(y)
    numbers[y] += 1
  end

  next unless numbers.values.include?(2)
  next if x.split('').sort.join != x
  total += 1
end

puts total