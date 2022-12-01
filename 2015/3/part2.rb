# frozen_string_literal: true

directions_chars = { '^' => [0, 1], 'v' => [0, -1], '>' => [1, 0], '<' => [-1, 0] }

both_directions = ARGF.read.chars
                      .partition
                      .each_with_index { |_char, index| index.even? }

visited = { [0, 0] => true }
both_directions.each do |directions|
  location = [0, 0]
  directions.each do |direction|
    direction_char = directions_chars[direction]
    location = [location[0] + direction_char[0], location[1] + direction_char[1]]
    visited[location] = true unless visited[location]
  end
end

puts "answer: #{visited.size}"
