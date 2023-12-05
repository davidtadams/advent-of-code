# frozen_string_literal: true

answer = ARGF.readlines(chomp: true).map do |line|
  winning_numbers, numbers = line.split(': ')[1].split(' | ').map(&:split)
  winners = winning_numbers & numbers
  winners.size.positive? ? 2**(winners.size - 1) : 0
end.sum

puts "answer: #{answer}"
