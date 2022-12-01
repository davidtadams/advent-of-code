# frozen_string_literal: true

positions = ARGF.read.split(',').map(&:to_i).sort

def median(sorted_array)
  middle = (sorted_array.length - 1) / 2.0
  (sorted_array[middle.floor] + sorted_array[middle.ceil]) / 2.0
end

median = median(positions)

fuel_cost = positions.reduce(0) { |acc, position| acc + (position - median).abs }.to_i

puts "answer: #{fuel_cost}"
