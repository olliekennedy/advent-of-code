input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("").map(&:to_i) }#.map(&:to_i)

@height = input.length
@width = input[0].length

def find_all_low_points(input)
  low_points = {}

  input.each_with_index do |y, j|
    y.each_with_index do |x, i|
      if i > 0
        next if y[i - 1] < x
      end
      if i < y.length - 1
        next if y[i + 1] < x
      end

      if j > 0
        next if input[j - 1][i] < x
      end
      if j < input.length - 1
        next if input[j + 1][i] < x
      end

      low_points[[i, j]] = x if x != 9
    end
  end
  low_points
end

low_points = find_all_low_points(input)

risk_levels = low_points.values.map { |x| x+1 }


puts low_points.inspect
puts risk_levels.sum

@checked_coords = []

def find_higher_points(input, coord)
  basin_size = 0

  x_coord = coord[0]
  y_coord = coord[1]

  if x_coord > 0 && input[y_coord][x_coord-1] > input[y_coord][x_coord] && input[y_coord][x_coord-1] < 9 && !@checked_coords.include?([x_coord-1, y_coord])
    @checked_coords << [x_coord-1, y_coord]
    puts "x_coord = #{x_coord-1}, y_coord = #{y_coord}"
    puts "Bigger!"
    puts "x is bigger than zero, so checking x-1"
    basin_size += find_higher_points(input, [x_coord-1, y_coord])
  end
  if x_coord < @width-1 && input[y_coord][x_coord+1] > input[y_coord][x_coord] && input[y_coord][x_coord+1] < 9 && !@checked_coords.include?([x_coord+1, y_coord])
    @checked_coords << [x_coord+1, y_coord]
    puts "x_coord = #{x_coord+1}, y_coord = #{y_coord}"
    puts "Bigger!"
    puts "x is less than length, so checking x+1"
    basin_size += find_higher_points(input, [x_coord+1, y_coord])
  end

  if y_coord > 0 && input[y_coord-1][x_coord] > input[y_coord][x_coord] && input[y_coord-1][x_coord] < 9 && !@checked_coords.include?([x_coord, y_coord-1])
    @checked_coords << [x_coord, y_coord-1]
    puts "x_coord = #{x_coord}, y_coord = #{y_coord-1}"
    puts "Bigger!"
    puts "y is bigger than zero"
    basin_size += find_higher_points(input, [x_coord, y_coord-1])
  end
  if y_coord < @height-1 && input[y_coord+1][x_coord] > input[y_coord][x_coord] && input[y_coord+1][x_coord] < 9 && !@checked_coords.include?([x_coord, y_coord+1])
    @checked_coords << [x_coord, y_coord+1]
    puts "x_coord = #{x_coord}, y_coord = #{y_coord+1}"
    puts "Bigger!"
    puts "y is less than length, so checking y+1"
    basin_size += find_higher_points(input, [x_coord, y_coord+1])
  end
  puts "Not bigger..."
  basin_size + 1
end

puts low_points.keys.map { |x| find_higher_points(input, x) }.max(3).inject(:*)