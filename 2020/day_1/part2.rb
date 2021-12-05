# frozen_string_literal: true

input = File.read("input.txt").split("\n").map(&:to_i)

selected_trio = input.combination(3).find { |pair| pair.sum == 2020 }
answer = selected_trio[0] * selected_trio[1] * selected_trio[2]

puts answer
