i = File.read('./input.txt').gsub("\n", "").split(",").map(&:to_i)
puts i.inspect

p = 0
while p < i.length do
  break if i[p] == 99
  if i[p] == 1
    i[i[p+3]] = i[i[p+1]] + i[i[p+2]]
  elsif i[p] == 2
    i[i[p+3]] = i[i[p+1]] * i[i[p+2]]
  end
  p += 4
end

puts i.inspect
