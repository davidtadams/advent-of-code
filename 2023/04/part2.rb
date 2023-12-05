# frozen_string_literal: true

scratch_cards = Array.new(200, 0)
ARGF.readlines(chomp: true).each_with_index do |line, game_index|
  scratch_cards[game_index] += 1
  winning_numbers, numbers = line.split(': ')[1].split(' | ').map(&:split)
  winners = winning_numbers & numbers

  scratch_cards[game_index].times do
    winners.size.times do |index|
      scratch_cards[game_index + index + 1] += 1
    end
  end
end

puts "answer: #{scratch_cards.sum}"
