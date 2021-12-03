# frozen_string_literal: true

numbers = ARGF.each_line.map(&:chomp)

def get_common_value(zeros, ones, most_common)
  if zeros > ones
    most_common ? '0' : '1'
  elsif ones > zeros || ones == zeros
    most_common ? '1' : '0'
  end
end

def calculate_rating(numbers:, most_common: true)
  current_index = 0

  while numbers.size > 1
    number_array_at_index = numbers.map { |number| number[current_index] }
    zeros = number_array_at_index.count('0')
    ones = number_array_at_index.count('1')
    common_value = get_common_value(zeros, ones, most_common)
    numbers = numbers.select { |number| number[current_index] == common_value }
    current_index += 1
  end

  numbers.first
end

oxygen_generator_rating = calculate_rating(numbers: numbers)
calculate_co2_scrubber_rating = calculate_rating(numbers: numbers, most_common: false)

answer = oxygen_generator_rating.to_i(2) * calculate_co2_scrubber_rating.to_i(2)
puts "answer: #{answer}"
