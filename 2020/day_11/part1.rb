# frozen_string_literal: true

GRID = File.read('./input.txt').split("\n").map { |line| line.split('') }

def print_grid(grid)
  grid.each do |row|
    p row.join
  end
  nil
end

# rubocop:todo Metrics/MethodLength
# rubocop:todo Metrics/AbcSize
def calculate_seat(row, column, grid) # rubocop:todo Metrics/CyclomaticComplexity
  seat = grid[row][column]

  return seat if seat == '.'

  row - 1 >= 0 ? top_row = row - 1 : top_row = 1_000_000
  column - 1 >= 0 ? left_column = column - 1 : left_column = 1_000_000
  top_left = grid.dig(top_row, left_column)
  top = grid.dig(top_row, column)
  top_right = grid.dig(top_row, column + 1)
  middle_left = grid.dig(row, left_column)
  middle_right = grid.dig(row, column + 1)
  bottom_left = grid.dig(row + 1, left_column)
  bottom = grid.dig(row + 1, column)
  bottom_right = grid.dig(row + 1, column + 1)

  occupied_adjacent_seats = [
    top_left,
    top,
    top_right,
    middle_left,
    middle_right,
    bottom_left,
    bottom,
    bottom_right
  ].count('#')

  return '#' if seat == 'L' && occupied_adjacent_seats.zero?

  return 'L' if seat == '#' && occupied_adjacent_seats >= 4

  seat
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

def calculate_seats(grid)
  occupied_seats = 0
  new_grid = Marshal.load(Marshal.dump(grid))

  grid.each_with_index do |row, row_index|
    row.each_with_index do |_column, column_index|
      new_seat = calculate_seat(row_index, column_index, grid)
      new_grid[row_index][column_index] = new_seat
      occupied_seats += 1 if new_seat == '#'
    end
  end

  [occupied_seats, new_grid]
end

prev_occupied_seats = -1
occupied_seats = 0
grid = GRID

while prev_occupied_seats != occupied_seats
  prev_occupied_seats = occupied_seats
  occupied_seats, grid = calculate_seats(grid)
end

p occupied_seats
