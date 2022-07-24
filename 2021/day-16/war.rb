def play(player1, player2, max_goes)

  goes = 1
  loop do

    return ["player2", goes] if player1.length <= 0
    return ["player1", goes] if player2.length <= 0

    shortest_length = [player1.length, player2.length].min
    return ["no winner", goes] if player1[0...shortest_length] == player2[0...shortest_length] || goes > max_goes

    sames = 0
    loop { player1[sames] == player2[sames] ? sames += 1 : break }

    extra = sames == 0 ? 1 : 2
    winners = []
    player1win = false
    if player1[sames] > player2[sames]
      player1win = true

    elsif player2[sames] > player1[sames]
      (sames + extra).times do
        return ["no winner", goes] if [player1[0], player2[0]].include?(nil)
        winners << player1.delete_at(0)
        winners << player2.delete_at(0)
      end
      winners = winners.sort_by { rand }
      player2 += winners
    else
      puts "ERROR"
      exit 1
    end

    (sames + extra).times do
      return ["no winner", goes] if [player1[0], player2[0]].include?(nil)
      winners << player1.delete_at(0)
      winners << player2.delete_at(0)
    end
    winners = winners.sort_by { rand }
    player1 += winners

    goes += 1
  end
end

outcome = []
max_goes = 5000
games = 1000
games.times do
  deck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
  shuffled_deck = deck.sort_by { rand }
  player1, player2 = shuffled_deck[0, 26], shuffled_deck[26, 26]

  outcome << play(player1, player2, max_goes)
end

puts "In #{games} games:"
puts "Player 1 won #{outcome.map{ |x| x[0] }.count("player1")} times."
puts "Player 2 won #{outcome.map{ |x| x[0] }.count("player2")} times."
puts "No winner #{outcome.map{ |x| x[0] }.count("no winner")} times (got stuck or number of goes went over #{max_goes})."

winners_goes = outcome.select{ |x| ["player1", "player2"].include?(x[0]) }.map{ |x| x[1] }
# distrib = winners_goes.sort.map{ |x| "x"*(x/12) }
#
# puts distrib
puts
puts "How many goes it took the winning games to finish (#{winners_goes.count} of the #{outcome.count} games had winners):"
puts "max: #{winners_goes.max} goes"
puts "min: #{winners_goes.min} goes"
puts "mean: #{winners_goes.sum / winners_goes.count} goes"

