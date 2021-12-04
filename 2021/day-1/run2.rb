input = File.readlines('./test-input.txt').map { |x| x.gsub("\n", "") }.map(&:to_i)
puts input.inspect

existing_sum = input[0] + input[1] + input[2]
puts "Sum is #{existing_sum}"
count = 0
input.each_with_index do |x, i|
  next if i < 3
  sum = input[i - 2] + input[i - 1] + x
  print "Sum is #{sum}"
  if sum > existing_sum
    puts " (increased)"
    count += 1
  elsif sum == existing_sum
    puts " (no change)"
  else
    puts " (decreased)"
  end
  existing_sum = input[i - 2] + input[i - 1] + x
end
puts count