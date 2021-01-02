@input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map{|x| x.gsub("no other bags.", "0")}.map{ |x| x.split(" contain ")}.map{|x| [x[0].gsub(" bags", ""),x[1].gsub(" bags", "").gsub(".","").gsub(" bag", "").split(", ")]}
seed = @input.detect { |x| x[0] == "shiny gold" }

def bags(ln)
  count = 1
  return nil if ln.nil?
  ln[1].each do |x|
    found = @input.detect { |y| y[0] == x.slice(2,200) }
    count += x[0].to_i * bags(found) if !bags(found).nil?
  end
  return count
end

puts "Total count is #{bags(seed) - 1}"
