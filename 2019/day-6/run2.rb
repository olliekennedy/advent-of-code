@input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split(')') }#.map(&:to_i)
# puts @input.inspect

def find_mass(x)
  orbiter = x[0]
  puts orbiter

  if orbiter == "COM"
    return
  end

  @input.each do |y|
    potential_mass = y[1]

    if potential_mass == orbiter
      find_mass(y)
    end
  end
end

# @input.each do |x|
#   if x[1] == "YOU"
#     find_mass(x)
#   end
# end

@input.each do |x|
  if x[1] == "SAN"
    find_mass(x)
  end
end