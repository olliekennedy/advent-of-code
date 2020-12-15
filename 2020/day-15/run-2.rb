require 'objspace'
input = File.read('./input.txt').split(",").map(&:to_i)
puts input.inspect

hash = {}
num = nil
(0...30000000).each do |i|
  if i < input.length
    num = input[i]
  elsif hash[num].length > 1
    num = hash[num][-1] - hash[num][-2]
  else
    num = 0
  end
  if hash[num].nil?
    hash[num] = [i]
  else
    hash[num] << i
  end
end
# puts hash
puts "hash size = #{ObjectSpace.memsize_of(hash) / 1000000}MB"
puts num
#
# (0...100000).each do |i|
#   num = i < input.length ? input[i] : hash[num].length >= 2 ? hash[num][-1] - hash[num][-2] : 0
#   hash[num].nil? ? hash[num] = [i] : hash[num] << i
# end
# puts num
