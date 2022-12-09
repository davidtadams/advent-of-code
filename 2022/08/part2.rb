# frozen_string_literal: true

grid = ARGF.readlines(chomp: true).map { |line| line.chars.map(&:to_i) }

def scenic_score_up?(row_index, column_index, grid)
  scenic_score = 0
  tree_value = grid[row_index][column_index]

  (row_index - 1).downto(0).each do |compare_row_index|
    scenic_score += 1
    return scenic_score if grid[compare_row_index][column_index] >= tree_value
  end

  scenic_score
end

def scenic_score_down?(row_index, column_index, grid)
  scenic_score = 0
  tree_value = grid[row_index][column_index]

  (row_index + 1).upto(grid.length - 1).each do |compare_row_index|
    scenic_score += 1
    return scenic_score if grid[compare_row_index][column_index] >= tree_value
  end

  scenic_score
end

def scenic_score_left?(row_index, column_index, grid)
  scenic_score = 0
  tree_value = grid[row_index][column_index]

  (column_index - 1).downto(0).each do |compare_column_index|
    scenic_score += 1
    return scenic_score if grid[row_index][compare_column_index] >= tree_value
  end

  scenic_score
end

def scenic_score_right?(row_index, column_index, grid)
  scenic_score = 0
  tree_value = grid[row_index][column_index]

  (column_index + 1).upto(grid[0].length - 1).each do |compare_column_index|
    scenic_score += 1
    return scenic_score if grid[row_index][compare_column_index] >= tree_value
  end

  scenic_score
end

max_score = 0

(1..(grid.length - 2)).each do |row_index|
  (1..(grid[0].length - 2)).each do |column_index|
    scenic_score = scenic_score_up?(row_index, column_index, grid) *
                   scenic_score_down?(row_index, column_index, grid) *
                   scenic_score_left?(row_index, column_index, grid) *
                   scenic_score_right?(row_index, column_index, grid)

    max_score = scenic_score if scenic_score > max_score
  end
end

puts "answer: #{max_score}"
