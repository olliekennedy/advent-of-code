big_input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split(" | ").map{ |y| y.split(" ") } }

big_total = 0

big_input.each do |input|

  signal_pattern = input[0].dup
  output_value = input[1].dup

  positions = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [] }
  nums = { 0 => [], 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [] }
  signal_pattern.each do |x|
    case x.length
      when 2 then nums[1] = x.split("").sort
      when 3 then nums[7] = x.split("").sort
      when 4 then nums[4] = x.split("").sort
      when 7 then nums[8] = x.split("").sort
      else next
    end
  end

  positions[1] = nums[7] - nums[1]

  signal_pattern.each do |x|
    if x.length == 6 && !(nums[1] - x.split("")).empty?
      nums[6] += x.split("").sort
      positions[3] = %w[a b c d e f g] - nums[6]
      positions[6] = nums[1] - positions[3]
    end
  end

  signal_pattern.each do |x|
    if x.split("").length == 5 && !(positions[6] - x.split("")).empty?
      nums[2] = x.split("").sort
      positions[2] = %w[a b c d e f g] - (nums[2] + positions[6])
    end
  end

  signal_pattern.each do |x|
    if x.split("").length == 5 && (nums[1] - x.split("")).empty?
      nums[3] = x.split("").sort
      positions[5] = %w[a b c d e f g] - (nums[3] + positions[2])
    end
  end

  positions[4] = nums[4] - positions.values.flatten
  positions[0] = %w[a b c d e f g] - positions.values.flatten
  nums[0] = %w[a b c d e f g] - positions[4]
  nums[9] = %w[a b c d e f g] - positions[5]
  nums[5] = %w[a b c d e f g] - (positions[3] + positions[5])

  big_total += output_value.map { |x| nums.key(x.split("").sort) }.join("").to_i
end

puts big_total

