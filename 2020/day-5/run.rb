input = File.readlines('./input.txt').map{ |x| x.gsub("\n", "") }.map{ |x| x.split("") }
# puts input.inspect

seats = []
input.each do |bp|
  row = [0,128]
  col = [0,7]
  bp.each do |char|
    if char == 'F'
      row[1] = row[1] - (row[1] - row[0])/2 - 1
      #puts "Char: #{char} - [#{row[0]},#{row[1]}]"
    elsif char == 'B'
      row[0] = row[1] - (row[1] - row[0])/2
      #puts "Char: #{char} - [#{row[0]},#{row[1]}]"
    elsif char == 'L'
      col[1] = col[1] - (col[1] - col[0])/2 - 1
    elsif char == 'R'
      col[0] = col[1] - (col[1] - col[0])/2
    end
  end
  id = (row[0] * 8) + col[0]
  seats << [row[0], col[0], id]
  #uts "Row: #{row[0]}, Col: #{col[0]}, ID: #{id}"
end
# puts seats.max()
# puts seats.min()

pot_seats = []
(1..128).each do |row|
  (1..7).each do |col|
    pot_seats << [row,col,(row*8)+col]
  end
end

pot_seats.each_with_index do |x, i|
  if !seats.include?(x) && seats.include?(pot_seats[i+1]) && seats.include?(pot_seats[i-1])
    puts x
  end
end
