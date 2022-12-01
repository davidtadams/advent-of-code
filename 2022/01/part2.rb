# frozen_string_literal: true

elves = ARGF.read.split("\n\n").map(&:split)

answer = elves.reduce([0, 0, 0]) do |top_three_elves, calories|
  calories = calories.map(&:to_i).sum

  top_three_elves.each_with_index do |top_elf_calories, index|
    if calories > top_elf_calories
      top_three_elves[index] = calories
      break
    end
  end

  top_three_elves.sort
end.sum

puts "answer: #{answer}"
