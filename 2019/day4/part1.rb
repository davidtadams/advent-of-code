# frozen_string_literal: true

min_range, max_range = File.read('input.txt').split('-')

def test_number(number) # rubocop:todo Metrics/AbcSize
  number = number.to_s
  invalid_number = false
  are_only_two_the_same = false

  number[1..].chars.each_with_index do |_character, index|
    if number[index + 1].to_i < number[index].to_i
      invalid_number = true
      break
    end

    next unless number[index] == number[index + 1]

    are_only_two_the_same = true

    are_only_two_the_same = false if number[index] == number[index - 1]
  end

  !invalid_number && are_only_two_the_same
end

total_valid_numbers = 0
current_number = min_range.to_i

while current_number < max_range.to_i
  current_number += 1
  total_valid_numbers += 1 if test_number(current_number)
end

puts total_valid_numbers
