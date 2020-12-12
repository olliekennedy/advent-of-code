input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.insert(1,".").split(".")}.map {|x| [x[0], x[1].to_i]}#.map(&:to_i)
puts input.inspect

def move(dist, dir = @dir)
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

def correct_degrees
  if @dir > 360
    @dir -= 360
  elsif @dir < 0
    @dir += 360
  elsif @dir == 360
    @dir = 0
  end
end

@x = 0
@y = 0
@dir = 90

input.each do |x|
  case x[0]
  when "F"
    move(x[1])
  when "N"
    move(x[1], 0)
  when "E"
    move(x[1], 90)
  when "S"
    move(x[1], 180)
  when "W"
    move(x[1], 270)
  when "L"
    @dir -= x[1]
    correct_degrees()
  when "R"
    @dir += x[1]
    correct_degrees()
  end
end

puts "x = #{@x}"
puts "y = #{@y}"
puts @x.abs + @y.abs
