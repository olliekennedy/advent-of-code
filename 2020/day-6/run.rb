input = File.read('./input.txt').split("\n\n").map{|x| x.split("\n") }.map{ |x| x.map{ |y| y.split("")}}#.map{ |x| x.gsub("\n", "") }#.map(&:to_i)
# puts input.inspect

output = []
input.each do |x|
  arr = []
  x.each do |y|
    y.each do |z|
      arr << z
    end
  end
  output << arr.uniq.length
end

puts output.sum
