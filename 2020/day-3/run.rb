input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.split("")}
# puts input.inspect

x = 0
y = 0
prod = 1
#slopes = [[3,1]]
slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
slopes.each do |sl|
  count = 0
  while y < input.length do
    x = x - input[0].length if x > input[0].length - 1
    count += 1 if input[y][x] == "#"
    x += sl[0]
    y += sl[1]
  end
  x = 0
  y = 0
  prod *= count
end
puts prod
