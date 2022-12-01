# frozen_string_literal: true

answer = ARGF.each_line(chomp: true).reduce(0) do |acc, line|
  length, width, height = line.split('x').map(&:to_i)
  side1 = length * width
  side2 = width * height
  side3 = height * length
  minimum_side = [side1, side2, side3].min
  acc + (2 * side1) + (2 * side2) + (2 * side3) + minimum_side
end

puts "answer: #{answer}"
