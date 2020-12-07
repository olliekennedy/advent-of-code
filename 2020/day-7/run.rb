input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{|x| x.gsub("no other bags.", "0")}.map{ |x| x.split(" contain ")}.map{|x| [x[0].gsub(" bags", ""),x[1].gsub(" bags", "").gsub(".","").gsub(" bag", "").split(", ").map{|y| y.slice(2,200)}]}#.map(&:to_i)
puts input.inspect

# puts input.detect {|x| x[0] == "shiny gold"}.inspect

def bagger(colour, input)
  if colour.nil?
    return false
  end
  if colour == "shiny gold"
    return true
  end
  if colour.kind_of?(Array)
    colour.each do |x|
      return true if bagger(x,input)
      return true if x == "shiny gold"
    end
    return false
  else
    found = input.detect {|x| x[0] == colour}
    return bagger(found[1],input)
  end
end

gold_count = 0
input.each do |x|
  gold = bagger(x[1],input)
  puts "#{x.inspect} is #{gold}"
  gold_count += 1 if gold
end

puts gold_count
