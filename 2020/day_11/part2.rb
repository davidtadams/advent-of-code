# frozen_string_literal: true

GRID = File.read("./input.txt").split("\n").map(&:chars)
GRID_ROW_MAX = GRID.size - 1
GRID_COLUMN_MAX = GRID[0].size - 1

# top left = [-1, -1] top = [-1, 0] top right = [-1, +1]
# middle left = [0, -1] middle right = [0, +1]
# bottom left = [+1, -1] bottom = [+1, 0] bottom right = [+1, +1]
DELTAS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

def in_grid(row, column)
  row >= 0 && row <= GRID_ROW_MAX && column >= 0 && column <= GRID_COLUMN_MAX
end

def scan_diagonal(row, column, grid, delta)
  has_occupied_seat = false
  row_change, column_change = delta
  new_row = row + row_change
  new_column = column + column_change

  while in_grid(new_row, new_column)
    seat = grid.dig(new_row, new_column)

    case seat
    when "#"
      has_occupied_seat = true
      break
    when "L"
      break
    end

    new_row += row_change
    new_column += column_change
  end

  has_occupied_seat
end

def calculate_seat(row, column, grid)
  seat = grid[row][column]

  return seat if seat == "."

  occupied_adjacent_seats = DELTAS.map { |delta| scan_diagonal(row, column, grid, delta) }.count(true)

  return "#" if seat == "L" && occupied_adjacent_seats.zero?

  return "L" if seat == "#" && occupied_adjacent_seats >= 5

  seat
end

def calculate_seats(grid)
  occupied_seats = 0
  new_grid = Marshal.load(Marshal.dump(grid))

  grid.each_with_index do |row, row_index|
    row.each_with_index do |_column, column_index|
      new_seat = calculate_seat(row_index, column_index, grid)
      new_grid[row_index][column_index] = new_seat
      occupied_seats += 1 if new_seat == "#"
    end
  end

  [occupied_seats, new_grid]
end

def compare_grid(grid1, grid2)
  grid1.each_with_index do |row, row_index|
    row.each_with_index do |_column, column_index|
      return false if grid1[row_index][column_index] != grid2[row_index][column_index]
    end
  end

  true
end

def find_occupied_seats(grid)
  previous_grid = grid

  loop do
    occupied_seats, new_grid = calculate_seats(previous_grid)
    return occupied_seats if compare_grid(previous_grid, new_grid)

    previous_grid = new_grid
  end
end

puts find_occupied_seats(GRID)
