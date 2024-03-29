# frozen_string_literal: true

floor = 0
position = 0
ARGF.read.chars.each_with_index do |char, index|
  if floor.negative?
    position = index
    break
  end
  floor += 1 if char == '('
  floor -= 1 if char == ')'
end

puts "answer: #{position}"
