input = File.read('./input.txt').split("\n\n").map{|x| x.split("\n") }.map{ |x| x.map{ |y| y.split("")}}#.map{ |x| x.gsub("\n", "") }#.map(&:to_i)
# puts input.inspect

output = 0
input.each do |x|
  arr = []
  x.each do |y|
    y.each do |z|
      arr << z
    end
  end
  count = []
  arr.each do |y|
    if arr.count(y) == x.length
      count << y
    end
  end
  puts count.uniq.inspect
  output += count.uniq.length
end

puts output
