input = File.read('./input.txt').split("\n")#.map{ |x| x.gsub("\n", "") }#.map(&:to_i)
puts input.inspect
rule_end = input.index("")
puts "*"
# puts rule_end
rules = input.slice(0,3)
# puts rules
# puts "*"
my_ticket = input.slice(rule_end + 2, 1)
# puts my_ticket
# puts "*"
nearby_tickets = input.slice(rule_end + 5, 4000000)
# puts nearby_tickets

nums = []
# puts rules.inspect
# puts rules[0].gsub(": ", "chickens").gsub(" or ", "chickens").split("chickens")
rules.each_with_index { |x, i| rules[i] = x.gsub(": ", "chickens").gsub(" or ", "chickens").split("chickens") }
rules.each do |x|
  x.each do |y|
    nums << y if y.include?("-")
  end
end
# puts nums.inspect
nums.each_with_index { |x, i| nums[i] = x.split("-").map(&:to_i)}
# puts nums.inspect

valid_nums = []
nums.each do |x|
  (x[0]..x[1]).each do |y|
    valid_nums << y if !valid_nums.include?(y)
  end
end
puts valid_nums.sort.inspect
puts "*"
puts nearby_tickets.inspect
nearby_tickets = nearby_tickets.map{ |x| x.split(",").map(&:to_i)}
puts nearby_tickets.inspect

invalids = []
nearby_tickets.each do |x|
  x.each do |y|
    invalids << y if !valid_nums.include?(y)
  end
end

puts invalids.sum
