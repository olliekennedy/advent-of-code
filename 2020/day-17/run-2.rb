world = Hash.new('.')
File.readlines('./input.txt').map(&:chomp).each_with_index do |line, x|
  line.split('').each_with_index { |char, y| world[[x,y,0,0]] = char }
end

generations = 6
i = 0
while i < generations do
  next_state = world.dup
  coordinates = world.keys
  min_x = coordinates.map { |coord| coord[0] }.min - 1
  max_x = coordinates.map { |coord| coord[0] }.max + 1
  min_y = coordinates.map { |coord| coord[1] }.min - 1
  max_y = coordinates.map { |coord| coord[1] }.max + 1
  min_z = coordinates.map { |coord| coord[2] }.min - 1
  max_z = coordinates.map { |coord| coord[2] }.max + 1
  min_w = coordinates.map { |coord| coord[3] }.min - 1
  max_w = coordinates.map { |coord| coord[3] }.max + 1

  (min_x..max_x).each do |x|
    (min_y..max_y).each do |y|
      (min_z..max_z).each do |z|
        (min_w..max_w).each do |w|
          neighbours = 0
          (-1..1).each do |diff_x|
            (-1..1).each do |diff_y|
              (-1..1).each do |diff_z|
                (-1..1).each do |diff_w|
                  next if diff_x == 0 && diff_y == 0 && diff_z == 0 && diff_w == 0
                  neighbours += 1 if world[[x + diff_x, y + diff_y, z + diff_z, w + diff_w]] == '#'
                end
              end
            end
          end

          case world[[x,y,z,w]]
          when '#'
            if [2,3].include?(neighbours)
              next_state[[x,y,z,w]] = '#'
            else
              next_state[[x,y,z,w]] = '.'
            end
          when '.'
            if neighbours == 3
              next_state[[x,y,z,w]] = '#'
            else
              next_state[[x,y,z,w]] = '.'
            end
          end
        end
      end
    end
  end
  world = next_state
  i += 1
end
puts world.values.select { |val| val == '#' }.length
