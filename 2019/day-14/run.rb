@mapping = {}

input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split(" => ") }
# input = input.map{ |x|
#   [x[0].split(", ").map{ |y| y.split(" ") }, x[1].split(" ")]
# }
# puts input.inspect

input.each { |x|
  output = x[1].split(" ")
  @mapping[output] = x[0].split(", ").map{ |y| y.split(" ") }
}

@mapping.each do |x|
  puts x.inspect
end
puts ""
puts ""

@ores = 0
@bank = {}

def find_ingredients(material, quantity)
  puts [material, quantity].inspect

  if material == "ORE"
    puts "Adding #{quantity} to @ores"
    @ores += quantity.to_i
    @bank[material] -= quantity.to_i
  end



  number = 1
  @mapping.each do |k,v|
    if k[1] == material

      if quantity.to_i >= k[0].to_i
        number = (quantity.to_i / k[0].to_i).ceil
      end

      v.each do |x|

        number.times do
          if v == "ORE"
            if @bank[material].nil?
              @bank[material] = quantity
            else
              @bank[material] += quantity
            end
          end
          @bank[material] -= (k[0].to_i + quantity.to_i)
          find_ingredients(x[1], x[0])
        end

      end

    end
  end

  # @mapping[[quantity, material]].each do |x|
  #   puts x.inspect
  #   if x[1] == "ORE"
  #     @ores += x[0]
  #     next
  #   end
  #
  #   find_ingredients(x[1], x[0])
  #
  # end

end

find_ingredients("FUEL", "1")

puts "OREs: #{@ores}"