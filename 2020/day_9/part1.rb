# frozen_string_literal: true

input = File.read("./input.txt").split("\n").map(&:to_i)

preamble = 25
current_index = preamble
answer = nil

while current_index < input.size
  lookback_values = input[current_index - preamble, current_index - 1]
  sums = lookback_values.permutation(2).to_a.map(&:sum).uniq

  unless sums.include?(input[current_index])
    answer = input[current_index]
    break
  end

  current_index += 1
end

puts answer
