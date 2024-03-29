boards = File.read('./test-input.txt').split("\n\n")
draws = boards.shift.split(",").map(&:to_i)
boards = boards.map { |x| x.split("\n").map { |y| y.split(" ").map { |z| [z.to_i, false] } } }

def find_winner(boards)
  boards.each do |board|
    [board, board.transpose].each do |attempts|
      attempts.each do |row|
        return board if row.count { |tile| tile[1] == true } == row.length
      end
    end
  end
  nil
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

draws.each do |draw|
  mark_boards(boards, draw)
  winning_board = find_winner(boards)

  unless winning_board.nil?
    puts sum_unmarked(winning_board) * draw
    break
  end
end