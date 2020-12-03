require './lib/advent.rb'

advent = Advent.new
input = File.readlines('./input.txt')
puts "The answer to the first part is #{advent.check(input)}"
# puts "The answer to the second part is #{finder.check2(input)}"
