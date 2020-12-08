input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{|x| x.gsub("+","")}.map{ |x| x.split(" ")}.map{|x| [x[0],x[1].to_i]}#
puts input.inspect

count = 0
acc = 0
pos = 0
while true do
  puts "Line = #{input[pos]}"
  break if input[pos].length == 3
  input[pos] << 1
  case input[pos][0]
  when "nop"
    pos += 1
  when "acc"
    acc += input[pos][1]
    pos += 1
  when "jmp"
    pos += input[pos][1]
  end
  puts "ACC = #{acc}"
  puts "POS = #{pos}"
  count += 1
end

puts acc
