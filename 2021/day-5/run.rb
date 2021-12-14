input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.split(" -> ").map { |y| { "x" => y.split(",").map(&:to_i)[0], "y" => y.split(",").map(&:to_i)[1] } } }#.map(&:to_i)
# puts input.inspect

def build_row

end

def build_grid(grid_size)
  row = []
  grid_size.times do
    row << 0
  end
  grid = []
  grid_size.times do
    grid << row.dup
  end
  grid
end

grid = build_grid(1000)

def populate_horizontal(start, finish, grid)
  range = start["y"] < finish["y"] ? (start["y"]..finish["y"]) : (finish["y"]..start["y"])

  range.each do |y|
    grid[y][start["x"]] += 1
  end
end

def populate_vertical(start, finish, grid)
  range = start["x"] < finish["x"] ? (start["x"]..finish["x"]) : (finish["x"]..start["x"])
  range.each do |x|
    grid[start["y"]][x] += 1
  end
end

input.each do |coord|
  start = coord[0]
  finish = coord[1]
  if start["x"] == finish["x"]
    populate_horizontal(start, finish, grid)
  end

  if start["y"] == finish["y"]
    populate_vertical(start, finish, grid)
  end
end

puts grid.sum { |x| x.count { |y| y > 1 } }
