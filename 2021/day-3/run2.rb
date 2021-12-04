input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split("") }#.map(&:to_i)
length = input[0].length
puts length/2
puts input.inspect

ogr = Marshal.load(Marshal.dump(input))
csr = Marshal.load(Marshal.dump(input))

gamma = []

puts ogr.inspect
(0..length-1).each do |x|
  zero_count = 0
  one_count = 0

  ogr.each do |y|
    zero_count+=1 if y[x] == "0"
  end
  ogr.each do |y|
    one_count+=1 if y[x] == "1"
  end
  puts "Zeroes = #{zero_count}"
  puts "Ones = #{one_count}"
  if zero_count > one_count
    ogr = ogr.select { |z| z[x] == "0" }
    puts "Well done zeroes"
  elsif zero_count < one_count
    ogr = ogr.select { |z| z[x] == "1" }
    puts "Well done ones"
  else
    ogr = ogr.select { |z| z[x] == "1" }
    puts "All equal"
  end
  puts ogr.inspect
  break if ogr.length < 2
  zero_count = 0
end

puts csr.inspect
(0..length-1).each do |x|
  zero_count = 0
  one_count = 0

  csr.each do |y|
    zero_count+=1 if y[x] == "0"
  end
  csr.each do |y|
    one_count+=1 if y[x] == "1"
  end
  puts "Zeroes = #{zero_count}"
  puts "Ones = #{one_count}"
  if zero_count < one_count
    csr = csr.select { |z| z[x] == "0" }
    puts "Well done zeroes"
  elsif zero_count > one_count
    csr = csr.select { |z| z[x] == "1" }
    puts "Well done ones"
  else
    csr = csr.select { |z| z[x] == "0" }
    puts "All equal"
  end
  puts csr.inspect
  break if csr.length < 2
  zero_count = 0
end

puts "******************"
puts "ogr = #{ogr.inspect}"
puts "csr = #{csr.inspect}"
puts "******************"

epsilon = gamma.map{ |x| x == "0" ? "1" : "0" }

g = gamma.join("").to_i(2)
e = epsilon.join("").to_i(2)

o = ogr.join("").to_i(2)
c = csr.join("").to_i(2)

puts "gamma = #{g}"
puts "epsilon = #{e}"
puts "ogr = #{o}"
puts "csr = #{c}"
puts "answer = #{o*c}"