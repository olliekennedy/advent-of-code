input = File.readlines('./input.txt')[0].split("").map(&:to_i)

def skeleton_array(number_of_layers, tall)
  layers = []
  layer = []

  tall.times do
    layer << []
  end

  number_of_layers.times do
    layers << layer.map(&:clone)
  end
  layers
end

def put_into_layers(input, wide, tall)
  number_of_layers = input.length / (wide * tall)

  numbers = input.map(&:clone)
  layers = skeleton_array(number_of_layers, tall)

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

wide = 25
tall = 6

layers = put_into_layers(input, wide, tall)

image = skeleton_array(input.length / (wide * tall), tall)[0]

layers.each do |layer|
  layer.each_with_index do |tall, j|
    tall.each_with_index do |wide, k|
      if [0,1].include?(image[j][k])
        next
      end
      image[j][k] = wide
    end
  end
end

image.each do |x|
  x.each do |y|
    if y == 0
      print "\u2B1C".encode('utf-8')
      print " "
    else
      print "  "
    end
  end
  puts
end

