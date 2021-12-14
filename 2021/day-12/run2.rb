input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "").split("-") }#.map(&:to_i)

@doors = {}
input.each do |x|
  @doors.key?(x[0]) ? @doors[x[0]] << x[1] : @doors[x[0]] = [x[1]]
  next if x[1] == "end"
  @doors.key?(x[1]) ? @doors[x[1]] << x[0] : @doors[x[1]] = [x[0]]
end
@doors.keys.each do |x|
  @doors[x] -= ["start"]
end

@distinct_paths = []

def find_path_from(existing_path)
  @doors[existing_path[-1]].each do |x|
    next if existing_path.filter { |y| /[[:lower:]]/.match(y) }.tally.values.max > 1 &&
      /[[:lower:]]/.match(x) &&
      existing_path.count(x) > 0
    new_path = existing_path + [x]
    new_path[-1] == "end" ? @distinct_paths << new_path : find_path_from(new_path)
  end
end

find_path_from(["start"])
puts @distinct_paths.count
