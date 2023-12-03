# frozen_string_literal: true

NUMBERS = %w[0 1 2 3 4 5 6 7 8 9].freeze

# [top left, top middle, top right, middle left, middle right, bottom left, bottom middle, bottom right]
ADJACENT_COORDS = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]].freeze

# create grid
GRID = ARGF.readlines(chomp: true).map(&:chars)

class GridNumber
  attr_reader :coordinates

  def initialize(x_coord, y_coord)
    # what if I checked if it was adjacent on creation and insert?
    @coordinates = [[x_coord, y_coord]]
  end

  def add_coord(x_coord, y_coord)
    @coordinates.push([x_coord, y_coord])
  end

  def to_number
    @coordinates.reduce('') { |string_number, (x_coord, y_coord)| string_number + GRID[y_coord][x_coord] }.to_i
  end

  def adjacent_to_symbol?
    @coordinates.any? { |(x_coord, y_coord)| search_adjacent(x_coord, y_coord) }
  end

  private

  def search_adjacent(x_coord, y_coord)
    ADJACENT_COORDS.any? { |(x_adj, y_adj)| coord_is_symbol?(x_coord + x_adj, y_coord + y_adj) }
  end

  def coord_is_symbol?(x_coord, y_coord)
    # return if coord is outside of matrix array boundary
    return false if y_coord.negative? || y_coord >= GRID.size || x_coord.negative? || x_coord >= GRID[0].size

    value = GRID[y_coord][x_coord]
    value != '.' && !NUMBERS.include?(value)
  end
end

numbers = []

# go through grid and store all numbers
GRID.each_with_index do |line, y_index|
  current_number = nil

  line.each_with_index do |char, x_index|
    if NUMBERS.include?(char)
      if current_number.nil?
        current_number = GridNumber.new(x_index, y_index)
      else
        current_number.add_coord(x_index, y_index)
      end

      # if end of line, add number
      numbers.push(current_number) if x_index == GRID[0].size - 1
    else
      numbers.push(current_number) unless current_number.nil?
      current_number = nil
    end
  end
end

# Filter out numbers that are not adjacent to a symbol
numbers.select!(&:adjacent_to_symbol?)

# sum all numbers
answer = numbers.reduce(0) { |sum, number| sum + number.to_number }

puts "answer: #{answer}"
