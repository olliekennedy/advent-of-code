input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("") }#.map(&:to_i)
# puts input.inspect

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

corrupted = []
input.each do |line|
  brackets = {}
  brackets.default = 0
  chain = []
  line.each_with_index do |x, i|
    chain << x if ["(", "[", "{", "<"].include?(x)

    if [")","]","}",">"].include?(x)
      if chain[-1] == pairs[x]
        chain.pop
      else
        corrupted << x
        break
      end
    end
  end
end



puts corrupted.sum { |x|
  case x
  when ")" then 3
  when "]" then 57
  when "}" then 1197
  when ">" then 25137
  end
}