boards = File.read('./input.txt').split("\n\n") #.map{ |x| x.gsub("\n", "") }#.map(&:to_i)
draws = boards.shift.split(",").map(&:to_i)
boards = boards.map { |x| x.split("\n").map { |y| y.split(" ").map { |z| [z.to_i, false] } } }
def remove_winners(boards)
  boards.each_with_index do |board, i|
    [board, board.transpose].each do |attempts|
      attempts.each do |row|
        if row.count { |tile| tile[1] == true } == row.length
          boards.delete_at(i)
        end
      end
    end
  end
  boards
end

def mark_boards(boards, draw)
  boards.each do |board|
    board.each do |row|
      row.each do |tile|
        tile[1] = true if tile[0] == draw
      end
    end
  end
end

def sum_unmarked(board)
  sum = 0
  board.each do |row|
    row.each do |tile|
      if tile[1] == false
        sum += tile[0]
      end
    end
  end
  sum
end

winning_board = []
draws.each_with_index do |draw, i|
  mark_boards(boards, draw)
  remaining_boards = remove_winners(boards)
  if remaining_boards.length == 1
    winning_board = Marshal.load(Marshal.dump(remaining_boards[0]))
  end

  if remaining_boards.length == 0
    puts (sum_unmarked(winning_board) - draw) * draw
    break
  end
end