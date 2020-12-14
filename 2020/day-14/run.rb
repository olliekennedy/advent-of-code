input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }#.map(&:to_i)
input = input.map { |x| x.gsub("mem[", "").gsub("] = ", ",").split(",") }
# puts mask.inspect
# puts input.inspect

mem = {}

# mask = input[0].slice(7,300).split("")

mask = ""

input.each do |x|
  if x[0][0,4] == "mask"
    mask = x[0].slice(7,300).split("")
    next
  end
  bin = '%036b' % x[1]
  mask.each_with_index do |y, i|
    next if y == "X"
    bin[i] = y
  end
  mem[x[0]] = bin
end

# puts mem

memArr = mem.values
memArr = memArr.map { |x| x.to_i(2) }
# puts "memArr = #{memArr}"
puts memArr.sum




# oneohone = "000000000000000000000000000001100101"
# puts "oneohone = #{oneohone.to_i(2)}"
