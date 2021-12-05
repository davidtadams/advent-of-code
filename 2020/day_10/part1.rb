# frozen_string_literal: true

adapters = File.read("./input.txt").split("\n").map(&:to_i).sort

DIFFERENCES = [1, 2, 3].freeze

def find_adapter(rating, adapters)
  found_rating = nil
  found_difference = nil

  DIFFERENCES.each do |difference|
    new_rating = rating + difference
    next unless adapters.include?(new_rating)

    found_rating = new_rating
    found_difference = difference
    break
  end

  [found_rating, found_difference]
end

current_rating = 0
max_adapter = adapters.max
difference_count = DIFFERENCES.each_with_object({}) do |difference, acc|
  acc[difference] = 0
end

while current_rating < max_adapter
  rating, difference = find_adapter(current_rating, adapters)
  difference_count[difference] += 1
  current_rating = rating
end

difference_count[3] += 1
answer = difference_count[1] * difference_count[3]
p answer
