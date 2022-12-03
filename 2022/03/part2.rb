# frozen_string_literal: true

PRIORITY = (('a'..'z').to_a + ('A'..'Z').to_a)
  .each_with_index.to_h { |char, index| [char, index + 1] }

lines = ARGF
  .readlines(chomp: true)
  .map(&:chars)

answer = 0

lines.each_slice(3) do |group|
  first, second, third = group
  item = (first & second & third)[0]
  answer += PRIORITY[item]
end

puts "answer: #{answer}"
