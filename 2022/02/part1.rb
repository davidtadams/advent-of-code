# frozen_string_literal: true

# a,x = rock
# b,y = paper
# c,z = scissors

# rock = 1
# paper = 2
# scissors = 3

# lose = 0
# draw = 3
# win = 6

# rock beats scissors
# scissors beats paper
# paper beats rock

# a,x = tie
# b,y = tie
# c,z = tie

# a,y = win
# a,z = lose

# b,x = lose
# b,z = win

# c,x = win
# c,y = lose

SCORES = {
  %w[A X] => 3 + 1, # tie - rock<>rock
  %w[B Y] => 3 + 2, # tie - paper<>paper
  %w[C Z] => 3 + 3, # tie - scissors<>scissors
  %w[A Y] => 6 + 2, # win - rock<>paper
  %w[A Z] => 0 + 3, # lose - rock<>scissors
  %w[B X] => 0 + 1, # lose - paper<>rock
  %w[B Z] => 6 + 3, # win - paper<>scissors
  %w[C X] => 6 + 1, # win - scissors<>rock
  %w[C Y] => 0 + 2, # lose - scissors<>paper
}.freeze

rounds = ARGF.readlines(chomp: true).map(&:split)
answer = rounds.reduce(0) { |score, round| score + SCORES[round] }

puts "answer: #{answer}"
