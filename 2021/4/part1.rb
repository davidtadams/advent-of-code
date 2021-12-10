numbers, _, *boards_input = ARGF.readlines(chomp: true)
numbers = numbers.split(",")
boards = []
boards_input
  .delete_if { |line| line == "" }
  .each_slice(5) { |board| boards.push(board.map(&:split)) }

drawn_numbers = numbers.shift(4)
winner = false
winning_board = nil

while winner == false
  drawn_numbers.push(numbers.shift)

  boards.each do |board|
    board.each do |board_row|
      winner = board_row.intersection(drawn_numbers) == board_row
      winning_board = board if winner
      break if winner
    end

    break if winner

    board.transpose.each do |board_column|
      winner = board_column.intersection(drawn_numbers) == board_column
      winning_board = board if winner
      break if winner
    end

    break if winner
  end
end

sum_of_unmarked_numbers = winning_board.flatten.difference(drawn_numbers).map(&:to_i).sum
answer = sum_of_unmarked_numbers * drawn_numbers.last.to_i
puts answer
