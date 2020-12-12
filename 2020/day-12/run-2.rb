input = File.readlines('./input.txt').map(&:chomp).map { |x| [x[0], x[1..-1].to_i] }

def rotate(dir, degrees)
  case degrees
  when 90
    dir == "R" ? @wayp = [@wayp[1], -@wayp[0]] : rotate("R", 270)
  when 180
    @wayp = [-@wayp[0], -@wayp[1]]
  when 270
    dir == "R" ? @wayp = [-@wayp[1], @wayp[0]] : rotate("R", 90)
  end
end

@x = 0
@y = 0
@wayp = [10,1]
input.each do |x|
  case x[0]
  when "F"
    @x += (@wayp[0] * x[1])
    @y += (@wayp[1] * x[1])
  when "N"
    @wayp[1] += x[1]
  when "E"
    @wayp[0] += x[1]
  when "S"
    @wayp[1] -= x[1]
  when "W"
    @wayp[0] -= x[1]
  when "L", "R"
    rotate(x[0], x[1])
  end
end

puts @x.abs + @y.abs
