# frozen_string_literal: true

SCORES = {
  %w[A A] => 3 + 1, # draw - rock<>rock
  %w[A B] => 6 + 2, # win - rock<>paper
  %w[A C] => 0 + 3, # lose - rock<>scissors
  %w[B A] => 0 + 1, # lose - paper<>rock
  %w[B B] => 3 + 2, # draw - paper<>paper
  %w[B C] => 6 + 3, # win - paper<>scissors
  %w[C A] => 6 + 1, # win - scissors<>rock
  %w[C B] => 0 + 2, # lose - scissors<>paper
  %w[C C] => 3 + 3, # draw - scissors<>scissors
}.freeze

OUTCOMES = {
  %w[A X] => %w[A C], # lose
  %w[A Y] => %w[A A], # draw
  %w[A Z] => %w[A B], # win
  %w[B X] => %w[B A], # lose
  %w[B Y] => %w[B B], # draw
  %w[B Z] => %w[B C], # win
  %w[C X] => %w[C B], # lose
  %w[C Y] => %w[C C], # draw
  %w[C Z] => %w[C A], # win
}.freeze

rounds = ARGF.readlines(chomp: true).map(&:split)
answer = rounds.reduce(0) { |score, round| score + SCORES[OUTCOMES[round]] }

puts "answer: #{answer}"
