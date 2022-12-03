# frozen_string_literal: true

PRIORITY = (('a'..'z').to_a + ('A'..'Z').to_a)
  .each_with_index.to_h { |char, index| [char, index + 1] }

lines = ARGF
  .readlines(chomp: true)
  .map(&:chars)
  .map { |line| line.each_slice(line.size / 2).to_a }

answer = lines.reduce(0) do |sum, line|
  first_half, second_half = line
  item = (first_half & second_half)[0]
  sum + PRIORITY[item]
end

puts "answer: #{answer}"
