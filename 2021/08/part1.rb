# frozen_string_literal: true

unique_segment_lenghts = [2, 3, 4, 7]
digits_with_unique_number_of_segments = 0

ARGF.each_line(chomp: true) do |line|
  _input, output = line.split(' | ')
  digits_with_unique_number_of_segments += output.split.count do |output_value|
    unique_segment_lenghts.include?(output_value.length)
  end
end

puts "answer: #{digits_with_unique_number_of_segments}"
