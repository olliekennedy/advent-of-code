cave = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.split("").map(&:to_i) }

part2 = true
if part2
  initial_width, initial_height = cave[0].length, cave.length
  4.times do
    cave.map! { |x| x + x.last(initial_width).map { |i| i+1 > 9 ? 1 : i+1 } }
    cave += cave.last(initial_height).map { |i| i.map { |j| j+1 > 9 ? 1 : j+1 } }
  end
end

width, height = cave[0].length, cave.length

def find_lowest_path(x, y, lowest_paths, input)
  left = lowest_paths[[x - 1, y]]
  up = lowest_paths[[x, y - 1]]
  right = lowest_paths[[x + 1, y]]
  down = lowest_paths[[x, y + 1]]
  [left, up, right, down].select { |path| !path.nil? }.min + input[y][x]
end

lowest_paths = {}
(1..).each do |iterator|
  puts "Loop #{iterator}"
  lp_before = Marshal.load(Marshal.dump(lowest_paths))
  
  (0...height).each do |j|
    (0...width).each do |i|
      lowest_paths[[i,j]] = i == 0 && j == 0 ? 0 : find_lowest_path(i, j, lowest_paths, cave)
    end
  end
  break if lp_before == lowest_paths
end

puts lowest_paths

puts "Answer = #{lowest_paths[[width-1, height-1]]}"