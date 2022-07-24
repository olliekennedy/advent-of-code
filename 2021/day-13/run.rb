input = File.read('./input.txt').split("\n\n")
points = input[0].split("\n").map { |x| x.split(",").map(&:to_i)}
folds = input[1].split("\n").map { |x| x.gsub("fold along ", "").split("=") }.map { |y| [y[0],y[1].to_i] }
puts points.inspect
puts folds.inspect

grid = []
row = []
(points.map { |x| x[0] }.max+1).times do
  row << "."
end

(points.map { |x| x[1] }.max+1).times do
  grid << row.dup
end

def print_nicely(input)
  input.each do |y|
    y.each do |x|
      print "#{x} "
    end
    puts
  end
end

points.each do |coord|
  grid[coord[1]][coord[0]] = "#"
end

# print_nicely(grid)
# puts "***************************************"

grid = grid.transpose

fold = folds[0]

top_half = grid[0..(fold[1]-1)]
bottom_half = grid[(fold[1]+1)..-1]

# print_nicely(top_half)
# puts "***************************************"
# print_nicely(bottom_half)

flipped_top_half = top_half.reverse
bottom_half.each_with_index do |y, j|
  y.each_with_index do |x, i|
    flipped_top_half[j][i] = x unless flipped_top_half[j][i] == "#"

  end
end

# print_nicely(flipped_top_half.reverse)
puts flipped_top_half.reverse.flatten.count("#")



