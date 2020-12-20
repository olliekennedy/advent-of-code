input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }#.map(&:to_i)
# puts input.inspect

class Object
  def is_number?
    to_f.to_s == to_s || to_i.to_s == to_s
  end
end

def inner_brackets(line)
  last_bracket = {}
  line.each_char.with_index do |char, i|
    last_bracket["("] = i if char == "("
    if char == ")" && !last_bracket["("].nil?
      last_bracket[")"] = i
      break
    end
  end
  return last_bracket
end

def calculate(calc)
  total = 0
  operator = "+"
  i = 0
  while i < calc.length do
    if calc[i].is_number?
      j = 1
      while true do
        if calc[i+j].is_number?
          j += 1
        else
          break
        end
      end
      case operator
      when "+" then total += calc[i,j].to_i
      when "*" then total *= calc[i,j].to_i
      end
    elsif calc[i] == " "
      j = 1
    else
      operator = calc[i]
      j = 1
    end
    i += j
  end
  total
end

input.each_with_index do |line, i|
  while true do
    puts line
    if !line.include?("(")
      line = calculate(line)
      puts line
      break
    end
    start = inner_brackets(line)["("]+1
    diff = inner_brackets(line)[")"] - start
    calculation = line[start, diff]
    line = line.gsub("(#{calculation})", calculate(calculation).to_s)

  end
  input[i] = line
end
puts input.inspect

puts "********"
puts input.sum
