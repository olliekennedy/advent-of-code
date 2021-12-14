input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "").split("-") }#.map(&:to_i)
# puts input.inspect

@doors = {}
input.each do |x|
  if @doors.key?(x[0])
    @doors[x[0]] << x[1]
  else
    @doors[x[0]] = [x[1]]
  end
  next if x[1] == "end"
  if @doors.key?(x[1])
    @doors[x[1]] << x[0]
  else
    @doors[x[1]] = [x[0]]
  end
end
@doors.keys.each do |x|
  @doors[x] -= ["start"]
end

puts @doors.inspect

@distinct_paths = []

def find_path_from(existing_path)
  puts "Existing path = #{existing_path}. Checking #{@doors[existing_path[-1]]}"
  @doors[existing_path[-1]].each do |x|
    puts "Now trying '#{x}'"
    next if existing_path.include?(x) && /[[:lower:]]/.match(x) && x != "end"
    next_path = existing_path + [x]
    puts "Found another door! : #{next_path}"
    if next_path[-1] == "end"
      puts "Found an ending with '#{x}'"
      @distinct_paths << next_path
    else
      find_path_from(next_path)
    end
  end
end

find_path_from(["start"])


my_answer = @distinct_paths.map{ |x| x.join(",")}
puts "My answer:"
my_answer.each { |x| puts x }

correct_answer = [
  "start,A,b,A,c,A,end",
  "start,A,b,A,end",
  "start,A,b,end",
  "start,A,c,A,b,A,end",
  "start,A,c,A,b,end",
  "start,A,c,A,end",
  "start,A,end",
  "start,b,A,c,A,end",
  "start,b,A,end",
  "start,b,end"
]

puts "Correct paths that I didn't find: #{correct_answer - my_answer}"
puts "Incorrect paths that I found: #{my_answer - correct_answer}"
puts my_answer.count
