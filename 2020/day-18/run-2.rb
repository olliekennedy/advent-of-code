input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }

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
  calc.split(" * ").map{ |x| x.split(" + ").map(&:to_i).sum }.inject(:*)
end

input.each_with_index do |line, i|
  while true do
    if !line.include?("(")
      line = calculate(line)
      break
    end
    start = inner_brackets(line)["("]+1
    diff = inner_brackets(line)[")"] - start
    calculation = line[start, diff]
    line = line.gsub("(#{calculation})", calculate(calculation).to_s)
  end
  input[i] = line
end
puts input.sum
