
input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map(&:to_i)
#puts input.inspect
def fueller(mass)
  puts mass
  fuel = (mass / 3).floor - 2
  return fuel < 0 ? 0 : fuel + fueller(fuel)
end


# puts fueller(1969)

puts input.map { |x| fueller(x) }.sum


# Fuel required to launch a given module
# is based on its mass. Specifically, to
# find the fuel required for a module,
# take its mass, divide by three, round down, and subtract 2.
