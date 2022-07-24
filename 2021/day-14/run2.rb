input = File.read('./test-input.txt').split("\n\n")
template = input[0]
rules = input[1].split("\n").map { |x| x.split(" -> ") }.to_h#.map { |x| [x[0], [x[1]]]}
# puts @rules.inspect
# puts template
# puts rules

paircount = Hash.new
paircount.default = 0
template.chars.each_cons(2) do |a, b|
  puts "a = #{a.inspect}, b = #{b.inspect}"
  paircount[a + b] += 1
end
puts paircount.inspect
40.times do
  existing_paircount = paircount.dup
  paircount = Hash.new(0)
  existing_paircount.each do |k, v|
    found = rules[k]
    paircount[k[0] + found] += v
    paircount[found + k[1]] += v
  end
end
t = Hash.new(0)
paircount.each do |k, v|
  t[k[0]] += v
end
t[template[-1]] += 1

puts t.values.max - t.values.min