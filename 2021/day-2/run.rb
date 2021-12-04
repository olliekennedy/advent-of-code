input = File.readlines('./test-input.txt').map{ |x| x.gsub("\n", "") }#.map(&:to_i)
puts input.inspect
