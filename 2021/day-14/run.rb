input = File.read('./test-input.txt').split("\n\n")
template = input[0].split("")
rules = input[1].split("\n").map { |x| x.split(" -> ") }.map { |x| [x[0], [x[1]]]}.to_h

(1..10).each do |x|
  template.each_with_index do |_, i|
    next if template[i].is_a?(Array)
    pair = [template[i],template[i+1]].join("")
    if rules.keys.include?(pair)
      template = template.insert(i+1, rules[pair])
    end
  end
  template = template.flatten
end

puts template.tally.values.max - template.tally.values.min