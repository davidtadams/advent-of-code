require 'pry'

tree_rows = File.read('./input.txt').split("\n").map do |input_line|
  input_line.split('')
end

SLOPES = [
  {
    run: 1,
    rise: 1,
  },
  {
    run: 3,
    rise: 1,
  },
  {
    run: 5,
    rise: 1,
  },
  {
    run: 7,
    rise: 1,
  },
  {
    run: 1,
    rise: 2,
  },
]
DEPTH_SIZE = tree_rows.size
ROW_SIZE = tree_rows[0].size

answer = SLOPES.map do |slope|
  run = slope[:run]
  rise = slope[:rise]
  current_x = 0
  current_y = rise
  tree_count = 0

  while current_y < DEPTH_SIZE
    if current_x + run > ROW_SIZE - 1
      current_x = (current_x + run) % ROW_SIZE
    else
      current_x += run
    end

    if tree_rows[current_y][current_x] == '#'
      tree_count += 1
    end

    current_y += rise
  end

  tree_count
end.reduce(:*)

puts answer
