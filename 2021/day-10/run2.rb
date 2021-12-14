input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("") }#.map(&:to_i)
puts input.count

pairs = {
  "(" => ")",
  ")" => "(",
  "[" => "]",
  "]" => "[",
  "{" => "}",
  "}" => "{",
  "<" => ">",
  ">" => "<"
}

totals = []
input = input.reject do |line|
  brackets = {}
  brackets.default = 0
  chain = []
  corrupted = false
  line.each_with_index do |x, i|
    chain << x if ["(", "[", "{", "<"].include?(x)

    if [")","]","}",">"].include?(x)
      if chain[-1] == pairs[x]
        chain.pop
      else
        corrupted = true

      end
    end
  end
  if corrupted
    next
  end
  complete_total = 0
  chain.reverse.each do |x|
    complete_total *= 5
    addition = case x
               when "(" then 1
               when "[" then 2
               when "{" then 3
               when "<" then 4
               end
    complete_total += addition
  end
  totals << complete_total
  corrupted
end

puts input.count

totals.sort!
elements = totals.count
center =  elements/2
puts elements.even? ? (totals[center] + totals[center+1])/2 : totals[center]