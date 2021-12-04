@input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split(')') }#.map(&:to_i)
# puts @input.inspect

@total = 0

def find_orbit_of(y)
  puts "Finding orbits for #{y}"
  _og_center = y[0]
  og_orbiter = y[1]

  orbits = 0
  @input.each do |relationship|
    puts "Checking #{relationship.inspect}"
    if y == relationship
      puts "Identical... skipping"
      next
    end

    center = relationship[0]
    _orbiter = relationship[1]

    if center == og_orbiter
      puts "Found one! It's #{center}"
      orbits += 1
      puts "Orbits for #{center}: #{orbits}"
      orbits += find_orbit_of(relationship)
    end
  end
  puts "Done checking orbits for #{og_orbiter}. There were #{orbits}"
  @total += orbits
  orbits
end

@input.each do |y|
  if y[0] == 'COM'
    puts find_orbit_of(["MELON","COM"])
  end
end

puts @total