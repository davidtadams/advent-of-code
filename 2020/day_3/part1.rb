require 'pry'

tree_rows = File.read('./input.txt').split("\n").map do |input_line|
  input_line.split('')
end
tree_rows.shift

RUN = 3
current_x = 0

answer = tree_rows.reduce(0) do |tree_count, tree_row|
  if current_x + RUN > tree_row.size - 1
    current_x = (current_x + RUN) % tree_row.size
  else
    current_x += RUN
  end

  if tree_row[current_x] == '#'
    tree_count += 1
  end

  tree_count
end

puts answer
