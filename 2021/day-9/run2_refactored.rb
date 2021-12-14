input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("").map(&:to_i) }

@height = input.length
@width = input[0].length

def find_all_low_points(input)
  low_points = {}

  input.each_with_index do |y, j|
    y.each_with_index do |x, i|
      next if i > 0 && y[i - 1] < x
      next if i < y.length - 1 && y[i + 1] < x
      next if j > 0 && input[j - 1][i] < x
      next if j < input.length - 1 && input[j + 1][i] < x

      low_points[[i, j]] = x if x != 9
    end
  end
  low_points
end

low_points = find_all_low_points(input)
puts "Part 1: #{low_points.values.map{|x| x+1 }.sum}"

@checked_coords = []
def find_higher_points(input, coord)
  basin_size = 0

  x_coord = coord[0]
  y_coord = coord[1]
  value = input[y_coord][x_coord]

  attempt = [x_coord - 1, y_coord]
  attempt_value = input[attempt[1]][attempt[0]]
  if x_coord > 0 && attempt_value > value && attempt_value < 9 && !@checked_coords.include?(attempt)
    @checked_coords << attempt
    basin_size += find_higher_points(input, attempt)
  end
  attempt = [x_coord + 1, y_coord]
  attempt_value = input[attempt[1]][attempt[0]]
  if x_coord < @width-1 && attempt_value > value && attempt_value < 9 && !@checked_coords.include?(attempt)
    @checked_coords << attempt
    basin_size += find_higher_points(input, attempt)
  end

  if y_coord > 0 && input[y_coord-1][x_coord] > value && input[y_coord-1][x_coord] < 9 && !@checked_coords.include?([x_coord, y_coord-1])
    @checked_coords << [x_coord, y_coord-1]
    basin_size += find_higher_points(input, [x_coord, y_coord-1])
  end
  if y_coord < @height-1 && input[y_coord+1][x_coord] > value && input[y_coord+1][x_coord] < 9 && !@checked_coords.include?([x_coord, y_coord+1])
    @checked_coords << [x_coord, y_coord+1]
    basin_size += find_higher_points(input, [x_coord, y_coord+1])
  end
  basin_size + 1
end

puts "Part 2: #{low_points.keys.map { |x| find_higher_points(input, x) }.max(3).inject(:*)}"