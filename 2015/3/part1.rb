# frozen_string_literal: true

directions = { '^' => [0, 1], 'v' => [0, -1], '>' => [1, 0], '<' => [-1, 0] }
location = [0, 0]
visited = { location => true }

ARGF.read.chars.each do |char|
  direction = directions[char]
  location = [location[0] + direction[0], location[1] + direction[1]]
  visited[location] = true unless visited[location]
end

p visited

puts "answer: #{visited.size}"
