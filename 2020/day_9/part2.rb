# frozen_string_literal: true

input = File.read('./input.txt').split("\n").map(&:to_i)

invalid_number = 85_848_519
current_index = 0
contiguous_range = []

while current_index < input.size
  sum = 0
  search_range = input[current_index..]
  end_index = nil

  search_range.each_with_index do |number, index|
    sum += number

    if sum == invalid_number
      end_index = current_index + index
      break
    elsif sum > invalid_number
      break
    end
  end

  if end_index
    contiguous_range = input[current_index..end_index]
    break
  end

  current_index += 1
end

puts contiguous_range.max + contiguous_range.min
