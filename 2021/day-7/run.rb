crab_positions = File.read('./input.txt').split(",").map(&:to_i)

puts (crab_positions.min..crab_positions.max).map { |centre|
  crab_positions.sum { |crab_position|
    distance = (crab_position - centre).abs
    (distance * (distance + 1)) / 2
  }
}.min