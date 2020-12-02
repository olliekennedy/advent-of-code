require './lib/password_checker.rb'

finder = PasswordChecker.new
input = File.readlines('./input.txt')
puts "The answer to the first part is #{finder.check(input)}"
puts "The answer to the second part is #{finder.check2(input)}"
# puts "The answer to the second part by txt file is #{finder.find(3, 2020)}"
