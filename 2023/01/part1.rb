# frozen_string_literal: true

answer = ARGF.readlines(chomp: true).reduce(0) do |sum, line|
  numbers_in_line = line.scan(/\d+/).join
  calibration_value = (numbers_in_line[0] + numbers_in_line[-1]).to_i
  sum + calibration_value
end

puts "answer: #{answer}"
