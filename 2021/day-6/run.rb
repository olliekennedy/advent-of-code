fish = File.read('./input.txt').split(",").map(&:to_i).tally
fish.default = 0

256.times do
  [7,9].each { |x| fish[x] += fish[0] }
  (0..9).each { |x| fish[x] = fish[x + 1] }
end

puts fish.values.sum
