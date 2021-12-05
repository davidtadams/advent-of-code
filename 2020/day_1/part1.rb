# frozen_string_literal: true

input = File.read("input.txt").split("\n").map(&:to_i)

selected_pair = input.combination(2).find { |pair| pair.sum == 2020 }
answer = selected_pair[0] * selected_pair[1]

puts answer
