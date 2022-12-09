# frozen_string_literal: true

grid = ARGF.readlines(chomp: true).map { |line| line.chars.map(&:to_i) }

def visible_up?(row_index, column_index, grid)
  tree_value = grid[row_index][column_index]

  (row_index - 1).downto(0).each do |compare_row_index|
    return false if grid[compare_row_index][column_index] >= tree_value
  end

  true
end

def visible_down?(row_index, column_index, grid)
  tree_value = grid[row_index][column_index]

  (row_index + 1).upto(grid.length - 1).each do |compare_row_index|
    return false if grid[compare_row_index][column_index] >= tree_value
  end

  true
end

def visible_left?(row_index, column_index, grid)
  tree_value = grid[row_index][column_index]

  (column_index - 1).downto(0).each do |compare_column_index|
    return false if grid[row_index][compare_column_index] >= tree_value
  end

  true
end

def visible_right?(row_index, column_index, grid)
  tree_value = grid[row_index][column_index]

  (column_index + 1).upto(grid[0].length - 1).each do |compare_column_index|
    return false if grid[row_index][compare_column_index] >= tree_value
  end

  true
end

interior_trees = 0

(1..(grid.length - 2)).each do |row_index|
  (1..(grid[0].length - 2)).each do |column_index|
    visible = visible_up?(row_index, column_index, grid) ||
              visible_down?(row_index, column_index, grid) ||
              visible_left?(row_index, column_index, grid) ||
              visible_right?(row_index, column_index, grid)

    interior_trees += 1 if visible
  end
end

exterior_trees = (grid.length * 2) + (grid[0].length * 2) - 4
answer = exterior_trees + interior_trees
puts "answer: #{answer}"
