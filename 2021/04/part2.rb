# frozen_string_literal: true

numbers, _, *boards_input = ARGF.readlines(chomp: true)
numbers = numbers.split(',')
boards = []
boards_input
  .delete_if { |line| line == '' }
  .each_slice(5) { |board| boards.push(board.map(&:split)) }

drawn_numbers = numbers.shift(4)
winner = false
last_winner = nil

while numbers.length.positive? && boards.length.positive?
  drawn_numbers.push(numbers.shift)

  boards.each_with_index do |board, board_index|
    board.each do |board_row|
      winner = board_row.intersection(drawn_numbers) == board_row
      next unless winner

      last_winner = board
      boards.delete_at(board_index)
      break
    end

    next if winner

    board.transpose.each do |board_column|
      winner = board_column.intersection(drawn_numbers) == board_column
      next unless winner

      last_winner = board
      boards.delete_at(board_index)
      break
    end
  end
end

sum_of_unmarked_numbers = last_winner.flatten.difference(drawn_numbers).map(&:to_i).sum
answer = sum_of_unmarked_numbers * drawn_numbers.last.to_i
puts answer
