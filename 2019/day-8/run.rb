input = File.readlines('./input.txt')[0].split("")

def put_into_layers(input, wide, tall)
  number_of_layers = input.length / (wide * tall)
  puts "Layers: #{number_of_layers}"

  numbers = input.map(&:clone)
  layers = []
  layer = []

  tall.times do
    layer << []
  end

  number_of_layers.times do
    layers << layer.map(&:clone)
  end

  layer_number = 0
  tall_number = 0
  while numbers.length > 0
    wide.times do
      layers[layer_number][tall_number] << numbers.shift
    end
    tall_number += 1
    if tall_number > tall - 1
      tall_number = 0
      layer_number += 1
    end
  end

  layers
end

layers = put_into_layers(input, 25, 6)

digits = layers.map(&:flatten)
fewest_zero_digits = digits
                       .map{ |x| x.count("0") }
                       .each_with_index.min[1]
puts "Answer: #{digits[fewest_zero_digits].count("1") *
  digits[fewest_zero_digits].count("2")}"

# [
#   [
#     [1,2,3],
#     [4,5,6]
#   ],
#
#   [
#     [7,8,9],
#     [0,1,2]
#   ]
# ]