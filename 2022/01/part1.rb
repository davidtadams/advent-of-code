# frozen_string_literal: true

elves = ARGF.read.split("\n\n").map(&:split)

answer = elves.reduce(0) do |max_calories, calories|
  calories = calories.map(&:to_i).sum

  (calories > max_calories) ? calories : max_calories
end

puts "answer: #{answer}"
