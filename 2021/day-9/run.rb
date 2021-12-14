input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("").map(&:to_i) }#.map(&:to_i)

def print_nicely(input)
  input.each do |y|
    y.each do |x|
      print "#{x} "
    end
    puts
  end
end

print_nicely(input)

low_points = []

input.each_with_index do |y, j|
  y.each_with_index do |x, i|
    if i > 0
      next if y[i-1] < x
    end
    if i < y.length-1
      next if y[i+1] < x
    end

    if j > 0
      next if input[j-1][i] < x
    end
    if j < input.length-1
      next if input[j+1][i] < x
    end

    low_points << x if x != 9
  end
end

risk_levels = low_points.map { |x| x.to_i+1 }


puts low_points.inspect
puts risk_levels.sum