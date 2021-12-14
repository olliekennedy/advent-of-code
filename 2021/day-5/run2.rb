input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.split(" -> ").map { |y| { "x" => y.split(",").map(&:to_i)[0], "y" => y.split(",").map(&:to_i)[1] } } }#.map(&:to_i)

def build_grid(grid_size)
  row = []
  grid_size.times { row << 0 }
  @grid = []
  grid_size.times { @grid << row.dup }
end

def count_overlaps
  @grid.sum { |x| x.count { |y| y > 1 } }
end

def populate_grid(input)
  input.each do |coord|
    start = coord[0]
    finish = coord[1]
    if start["y"] == finish["y"]
      populate_horizontal(start, finish)
    elsif start["x"] == finish["x"]
      populate_vertical(start, finish)
    else
      populate_diagonal(start, finish)
    end
  end
end

def populate_horizontal(start, finish)
  range = start["x"] < finish["x"] ? (start["x"]..finish["x"]) : (finish["x"]..start["x"])
  range.each { |x| @grid[start["y"]][x] += 1 }
end

def populate_vertical(start, finish)
  range = start["y"] < finish["y"] ? (start["y"]..finish["y"]) : (finish["y"]..start["y"])
  range.each { |y| @grid[y][start["x"]] += 1 }
end

def populate_diagonal(start, finish)
  curr_x = start["x"]
  curr_y = start["y"]
  loop do
    @grid[curr_y][curr_x] += 1
    break if curr_x == finish["x"] || curr_y == finish["y"]
    finish["x"] > start["x"] ? curr_x += 1 : curr_x -= 1
    finish["y"] > start["y"] ? curr_y += 1 : curr_y -= 1
  end
end

build_grid(1000)
populate_grid(input)
puts count_overlaps