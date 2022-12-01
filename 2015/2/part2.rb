# frozen_string_literal: true

answer = ARGF.each_line(chomp: true).reduce(0) do |acc, line|
  sides = line.split('x').map(&:to_i)
  present_wrapping = sides.sort.first(2).sum * 2
  bow_wrapping = sides.reduce(:*)
  acc + present_wrapping + bow_wrapping
end

puts "answer: #{answer}"
