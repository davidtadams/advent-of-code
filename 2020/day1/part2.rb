input = File.read('input.txt').split("\n").map(&:to_i)

selected_trio = input.combination(3).select { |pair| pair.sum == 2020 }.first
answer = selected_trio[0] * selected_trio[1] * selected_trio[2]

puts answer
