input = File.readlines('./input.txt').map(&:chomp)
input = [input[0].to_i, input[1].split(",").map {|y| y == "x" ? "x" : y.to_i }]
# puts input.inspect

products = {}
input[1].each_with_index do |x, i|
  # puts x
  next if x == "x"
  product = x
  # puts input[0]
  while product < input[0]
    # puts product
    product += x
  end
  products[x] = product
end

# puts products.inspect

min = products.group_by(&:last).min_by(&:first).last.to_h

# puts "min = #{products.group_by(&:last).min_by(&:first).last.to_h}"

min.each do |k, v|
  puts k * (v - input[0])
end
