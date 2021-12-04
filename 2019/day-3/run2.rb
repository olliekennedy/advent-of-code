input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split(",").map{ |y|
  [y[0], y[1..-1].to_i]
} }
wire1 = input[0]
wire2 = input[1]
# puts wire1.inspect
# puts wire2.inspect

crossed_points = []

wire1_points = []
wire2_points = []

x = 0
y = 0
wire1.each do |i|
  case i[0]
  when "R"
    i[1].times do
      x += 1
      wire1_points.push([x,y])
    end
  when "L"
    i[1].times do
      x -= 1
      wire1_points.push([x,y])
    end
  when "U"
    i[1].times do
      y += 1
      wire1_points.push([x,y])
    end
  when "D"
    i[1].times do
      y -= 1
      wire1_points.push([x,y])
    end
  end
end

x = 0
y = 0
wire2.each do |i|
  case i[0]
  when "R"
    i[1].times do
      x += 1
      wire2_points.push([x,y])
    end
  when "L"
    i[1].times do
      x -= 1
      wire2_points.push([x,y])
    end
  when "U"
    i[1].times do
      y += 1
      wire2_points.push([x,y])
    end
  when "D"
    i[1].times do
      y -= 1
      wire2_points.push([x,y])
    end
  end
end

# puts wire1_points.inspect
# puts wire2_points.inspect

common = wire1_points & wire2_points
# puts common.inspect

lowest_sum = 91237412

common.each_with_index do |_, i|
  sum = wire1_points.find_index(common[i]) + wire2_points.find_index(common[i])
  if sum < lowest_sum
    lowest_sum = sum + 2
  end
end

puts "lowest_sum = #{lowest_sum}"

man_distances = common.map do |x|
  x.each_with_index do |y, i|
    if y < 0
      x[i] = y * -1
    end
  end
  x.sum
end

puts man_distances.min