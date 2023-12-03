# frozen_string_literal: true

NUMBERS = %w[0 1 2 3 4 5 6 7 8 9].freeze

# [top left, top middle, top right, middle left, middle right, bottom left, bottom middle, bottom right]
ADJACENT_COORDS = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]].freeze

GRID = ARGF.readlines(chomp: true).map(&:chars)

class Gear
  attr_reader :part_numbers

  def initialize(x_coord, y_coord)
    @x_coord = x_coord
    @y_coord = y_coord
    @part_numbers = set_part_numbers
  end

  def gear_ratio
    part_numbers.to_a.reduce(&:*)
  end

  private

  def set_part_numbers
    part_numbers = Set.new
    ADJACENT_COORDS.each do |(x_adj, y_adj)|
      number = get_number(@x_coord + x_adj, @y_coord + y_adj)
      part_numbers.add(number) unless number.nil?
    end
    part_numbers
  end

  def get_number(x_coord, y_coord)
    return nil if y_coord.negative? || y_coord >= GRID.size || x_coord.negative? || x_coord >= GRID[0].size

    return nil unless NUMBERS.include?(GRID[y_coord][x_coord])

    x_start = find_number_start(x_coord, y_coord)
    get_number_from_start(x_start, y_coord)
  end

  def find_number_start(x_coord, y_coord)
    return x_coord if x_coord.zero?

    while x_coord >= 0
      break unless NUMBERS.include?(GRID[y_coord][x_coord - 1])

      x_coord -= 1
    end

    x_coord
  end

  def get_number_from_start(x_coord, y_coord)
    number = GRID[y_coord][x_coord]

    loop do
      break if x_coord >= GRID[0].size

      next_value = GRID[y_coord][x_coord + 1]

      break unless NUMBERS.include?(next_value)

      number += next_value
      x_coord += 1
    end

    number.to_i
  end
end

gear_ratios = []
GRID.each_with_index do |row, y_coord|
  row.each_with_index do |value, x_coord|
    if value == '*'
      gear = Gear.new(x_coord, y_coord)
      gear_ratios.push(gear.gear_ratio) if gear.part_numbers.size == 2
    end
  end
end

puts "answer: #{gear_ratios.sum}"
