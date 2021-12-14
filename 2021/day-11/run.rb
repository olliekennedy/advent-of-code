input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("").map(&:to_i) }#.map(&:to_i)
# puts input.inspect

def print_nicely(input)
  puts "*******************"
  input.each do |y|
    y.each do |x|
      print "#{x} "
    end
    puts
  end
end

def count_surrounding_zeroes(input, i, j)
  count = 0
  ((j-1)..(j+1)).each do |y|
    ((i-1)..(i+1)).each do |x|
      next if x < 0 || y < 0 || x > 9 || y > 9
      next if y == j && x == i
      count += 1 if input[y][x] == 0
    end
  end
  count
end

# print_nicely(input)
flashes = 0

last_flashes = 0
step_counter = 1
while last_flashes != 100 do

  input = input.map { |y| y.map { |x|
    x > 8 ? 0 : x + 1
  } }

  iteration = 1
  while true
    # puts "Iteration #{iteration}"
    iteration += 1
    changed = false
    input = input.map { |y| y.map { |x|
      # x > 9 ? 0 : x
      if x > 9
        # flashes += 1
        0
      else
        x
      end
    } }
    # print_nicely(input)
    input.each_with_index do |y, j|
      y.each_with_index do |x, i|
        next if x <= 0
        count = count_surrounding_zeroes(input, i, j)
        if count > 0
          # puts "[#{i}, #{j}] is surrounded by #{count} zeroes"
          changed = true
          input[j][i] += count
        end
      end
    end
    break unless changed
    input = input.map { |y| y.map { |x|
      x == 0 ? -1 : x
      # if x == 0
      #   flashes += 1
      #   -1
      # else
      #   x
      # end
    } }
  end
  input = input.map { |y| y.map { |x|
    x == -1 ? 0 : x
    # if x == -1
    #   flashes += 1
    #   0
    # else
    #   x
    # end
  } }
  last_flashes = input.flatten.count(0)
  flashes += last_flashes

  puts "Flashes after #{step_counter} steps: #{flashes}"
  step_counter += 1

end

print_nicely(input)
puts "Flashes = #{flashes}"