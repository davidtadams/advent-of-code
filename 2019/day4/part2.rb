# frozen_string_literal: true

min_range, max_range = File.read("input.txt").split("-")

def test_number(number)
  number = number.to_s
  invalid_number = false
  are_only_two_the_same = false

  front_three = number[0..2]
  back_three = number[-3..]

  are_only_two_the_same = true if front_three[0] == front_three[1] && front_three[1] != front_three[2]

  are_only_two_the_same = true if back_three[1] == back_three[2] && back_three[1] != back_three[0]

  number.chars.each_with_index do |_character, index|
    if index != 0 && number[index] < number[index - 1]
      invalid_number = true
      break
    end

    not_front_or_back = index != 0 || index != 1 || index != number.size - 1 || index != number.size - 2

    if !are_only_two_the_same && not_front_or_back && number[index] == number[index + 1] &&
        number[index] != number[index - 1] && number[index] != number[index + 2]
      are_only_two_the_same = true
    end
  end

  !invalid_number && are_only_two_the_same
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/PerceivedComplexity

def test_range(min, max)
  total_valid_numbers = 0
  current_number = min.to_i

  while current_number < max.to_i
    current_number += 1
    total_valid_numbers += 1 if test_number(current_number)
  end

  total_valid_numbers
end

puts test_range(min_range, max_range)
