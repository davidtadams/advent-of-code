min_range, max_range = File.read("input.txt").split('-')

def test_number(number)
  number = number.to_s
  invalid_number = false
  are_only_two_the_same = false

  number[1..].split('').each_with_index do |character, index|
    if number[index + 1].to_i < number[index].to_i
      invalid_number = true
      break
    end

    if number[index] == number[index + 1]
      are_only_two_the_same = true

      if number[index] == number[index - 1]
        are_only_two_the_same= false
      end
    end
  end

  return !invalid_number && are_only_two_the_same
end

total_valid_numbers = 0
current_number = min_range.to_i

while current_number < max_range.to_i do
  current_number += 1
  if test_number(current_number)
    total_valid_numbers += 1
  end
end

puts total_valid_numbers
