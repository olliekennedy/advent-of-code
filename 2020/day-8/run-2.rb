@input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{|x| x.gsub("+","")}.map{ |x| x.split(" ")}.map{|x| [x[0],x[1].to_i]}#
#puts @input.inspect

def jmpNopSwitch(i)
  if @input[i][0] == "jmp"
    @input[i][0] = "nop"
  elsif @input[i][0] == "nop"
    @input[i][0] = "jmp"
  end
end

acc = 0
pos = 0
i = -1
while true do
  jmpNopSwitch(i) if i != -1
  success = true
  while true do
    break if pos > @input.length-1
    if @input[pos].length == 3 || @input[pos] == ["jmp", 0]
      success = false
      break
    end
    @input[pos] << 1
    case @input[pos][0]
      when "nop"
        pos += 1
      when "acc"
        acc += @input[pos][1]
        pos += 1
      when "jmp"
        pos += @input[pos][1]
    end
  end
  break if success
  jmpNopSwitch(i)
  @input = @input.each { |x| x.delete_at(2) }
  acc = pos = 0
  i += 1
end

puts acc
