input = File.read('./input.txt').split("\n")#.map{ |x| x.gsub("\n", "") }#.map(&:to_i)
# puts input.inspect
rule_end = input.index("")
puts "*"
# puts rule_end
rules = input.slice(0,rule_end)
# puts rules
# puts "*"
my_ticket = input.slice(rule_end + 2, 1)
# puts my_ticket
# puts "*"
nearby_tickets = input.slice(rule_end + 5, 4000000)
# puts nearby_tickets
ruleos = rules.map(&:clone)
ruleos.each_with_index { |x, i| ruleos[i] = x.gsub(": ", "chickens").gsub(" or ", "chickens").split("chickens") }
nums = []
# puts rules.inspect
# puts rules[0].gsub(": ", "chickens").gsub(" or ", "chickens").split("chickens")
# puts rules.inspect
rule_hash = {}
rules.each_with_index { |x, i| rules[i] = x.gsub(": ", "chickens").gsub(" or ", "chickens").split("chickens") }
# puts rules.inspect
rules.each_with_index do |x, i|
  rules[i][1] = rules[i][1].split("-")
  arr = []
  (rules[i][1][0]..rules[i][1][1]).each { |y| arr << y }
  # rules[i][1] = arr.map(&:to_i)
  rules[i][2] = rules[i][2].split("-")
  # arr = []
  (rules[i][2][0]..rules[i][2][1]).each { |y| arr << y }
  rules[i][1] = arr.map(&:to_i)
  rules[i].pop
  rule_hash[rules[i][0]] = rules[i][1]
end
# puts rule_hash.inspect

ruleos.each do |x|
  x.each do |y|
    nums << y if y.include?("-")
  end
end
# rule_hash[y[0]] =
# puts nums.inspect
nums.each_with_index { |x, i| nums[i] = x.split("-").map(&:to_i)}
# puts nums.inspect

valid_nums = []
nums.each do |x|
  (x[0]..x[1]).each do |y|
    valid_nums << y if !valid_nums.include?(y)
  end
end
# puts valid_nums.inspect
# puts "********"
# puts valid_nums.sort.inspect
# puts "*"
# puts nearby_tickets.inspect
nearby_tickets = nearby_tickets.map{ |x| x.split(",").map(&:to_i)}
# puts nearby_tickets.inspect
# puts nearby_tickets.inspect

invalids = []
nearby_tickets.each_with_index do |x, i|
  valid = true
  x.each do |y|
    valid = false if !valid_nums.include?(y)
  end
  invalids << i if valid == false
end
# puts invalids.inspect

valid_nearby_tickets = []
nearby_tickets.each_with_index do |x, i|
  valid_nearby_tickets << x if !invalids.include?(i)
end
# puts valid_nearby_tickets.inspect

# puts invalids.inspect
# puts rules.inspect
roundup = {}
(0..rules.length-1).each do |i|
  to_check = []
  valid_nearby_tickets.each do |x|
    # puts "I'm valid"
    to_check << x[i]
  end
  # puts to_check.inspect
  # puts "*"
  # puts "rule #{i} is "
  poss_rules = rule_hash.select { |key, arr|
    (to_check - arr).empty?
  }
  roundup[i] = poss_rules.keys
  # puts "*"
end
puts roundup.inspect
certified = {}
while certified.length < rules.length do
  single = roundup.select { |key, arr| arr.length == 1 }
  certified[single.keys[0]] = single.values[0][0]
  # puts single.values[0][0].inspect
  roundup.each do |key, arr|
    roundup[key] = arr - single.values[0]
  end
  puts roundup.inspect
end
puts certified.inspect

departures = certified.select { |key, value| value.slice(0,9) == "departure"}
# puts departures.inspect

my_ticket = my_ticket[0].split(",").map(&:to_i)

my_departures = []
departures.keys.each do |i|
  my_departures << my_ticket[i]
end
puts my_departures.inject(:*)
