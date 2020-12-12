input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map { |x| x.insert(1,".").split(".")}.map {|x| [x[0], x[1].to_i]}#.map(&:to_i)
puts input.inspect



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
@wayp = [10,1]

def move(dist)
  @x += (@wayp[0] * dist)
  @y += (@wayp[1] * dist)
end

def rotate(dir, degrees)
  if dir == "R"
    case degrees
    when 90
      @wayp = [@wayp[1], -@wayp[0]]
    when 180
      @wayp = [-@wayp[0], -@wayp[1]]
    when 270
      @wayp = [-@wayp[1], @wayp[0]]
    end
  else
    case degrees
    when 90
      @wayp = [-@wayp[1], @wayp[0]]
    when 180
      @wayp = [-@wayp[0], -@wayp[1]]
    when 270
      @wayp = [@wayp[1], -@wayp[0]]
    end
  end
end

input.each do |x|
  case x[0]
  when "F"
    move(x[1])
  when "N"
    @wayp[1] += x[1]
  when "E"
    @wayp[0] += x[1]
  when "S"
    @wayp[1] -= x[1]
  when "W"
    @wayp[0] -= x[1]
  when "L"
    rotate("L", x[1])
  when "R"
    rotate("R", x[1])
  end
end



puts "x = #{@x}"
puts "y = #{@y}"
puts @x.abs + @y.abs
