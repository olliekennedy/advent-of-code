input = File.read('./input.txt').split("\n")
end_of_rules = input.index("")
rules = input.slice(0,end_of_rules).map! { |x| x.split(Regexp.union([': ', ' or '])) }
my_ticket = input.slice(end_of_rules + 2, 1)[0].split(",").map(&:to_i)
nearby = input.slice(end_of_rules + 5, 4000000).map { |x| x.split(",").map(&:to_i) }

nums = []
rules.each { |x| nums += [x[1],x[2]] }
nums.map! { |x| x.split("-").map(&:to_i) }

valid_nums = []
nums.each do |x|
  (x[0]..x[1]).each { |y| valid_nums << y if !valid_nums.include?(y) }
end

rule_hash = {}
rules.each_with_index do |x, i|
  arr = []
  rules[i][1] = rules[i][1].split("-")
  (rules[i][1][0]..rules[i][1][1]).each { |y| arr << y }

  rules[i][2] = rules[i][2].split("-")
  (rules[i][2][0]..rules[i][2][1]).each { |y| arr << y }

  rules[i][1] = arr.map(&:to_i)
  rules[i].pop
  rule_hash[rules[i][0]] = rules[i][1]
end

valid_nearby = []
nearby.each_with_index do |x, i|
  valid = true
  x.each { |y| valid = false if !valid_nums.include?(y) }
  valid_nearby << x if valid
end

possible_fields = {}
(0..rules.length-1).each do |i|
  to_check = []
  valid_nearby.each { |x| to_check << x[i] }
  possible_fields[i] = rule_hash.select { |key, arr| (to_check - arr).empty? }.keys
end

certified = {}
while certified.length < rules.length do
  single_poss = possible_fields.select { |key, arr| arr.length == 1 }
  certified[single_poss.keys[0]] = single_poss.values[0][0]
  possible_fields.each do |key, arr|
    possible_fields[key] = arr - single_poss.values[0]
  end
end

departures = certified.select { |key, value| value.slice(0,9) == "departure"}

my_departures = []
departures.keys.each do |i|
  my_departures << my_ticket[i]
end
puts my_departures.inject(:*)
