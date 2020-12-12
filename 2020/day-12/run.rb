input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.insert(1,".").split(".")}.map {|x| [x[0], x[1].to_i]}#.map(&:to_i)
# puts input.inspect

def move(dist, dir)
  dir = @dir if dir.nil?
  case dir
  when 0
    @y += dist
  when 90
    @x += dist
  when 180
    @y -= dist
  when 270
    @x -= dist
  end
end

@x = 0
@y = 0
@dir = 90
dirs = { "N" => 0, "E" => 90, "S" => 180, "W" => 270 }

input.each do |x|
  case x[0]
  when "N", "E", "S", "W", "F"
    move(x[1], dirs[x[0]])
  when "L"
    @dir = (@dir - x[1]) % 360
  when "R"
    @dir = (@dir + x[1]) % 360
  end
end

puts @x.abs + @y.abs
