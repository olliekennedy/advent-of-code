input = File.readlines('./input.txt').map(&:chomp)
input = input[1].split(",").map { |y| y == "x" ? nil : y.to_i }
puts input.inspect

# def chinese_remainder(mods, remainders)
#   max = mods.inject( :* )
#   series = remainders.zip( mods ).map{|r,m| r.step( max, m ).to_a }
#   series.inject( :& ).first #returns nil when empty
# end

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  if g != 1
    raise 'Multiplicative inverse modulo does not exist!'
  end
  x % et
end

def chinese_remainder(mods, remainders)
  max = mods.inject( :* )  # product of all moduli
  series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
  series.inject( :+ ) % max
end


# input.gsub("x", 1)

# i = 0
# while true do
#
# puts input.reduce(1, :lcm)
# while true do
#   hashy = {}
#   total = 0
mods = []
rems = []
indexes = []
input.each_with_index do |x, i|
  # puts x
  next if x.nil?
  # puts x
  mods << x
  rems << (-i % x)
  indexes.push(i)
end

puts mods.inspect
puts rems.inspect
puts indexes.inspect

puts chinese_remainder(mods, rems)
#   hashy.each do |k,v|
#     if
#   end
#
# end
#
