# frozen_string_literal: true

require 'set'

ADJACENT_CORDS = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]].freeze

grid = []
ARGF.each_line(chomp: true) { |line| grid.push(line.chars.map(&:to_i)) }

def increment_all(grid, flash_stack)
  grid.each_with_index do |row, y_index|
    row.each_with_index do |_octopus, x_index|
      grid[y_index][x_index] += 1
      if grid[y_index][x_index] > 9
        grid[y_index][x_index] = 0
        flash_stack.push([x_index, y_index])
      end
    end
  end
end

def flash(octopus, grid, flash_stack, flashed_set)
  return if flashed_set.include?(octopus)

  octopus_x = octopus[0]
  octopus_y = octopus[1]
  grid[octopus_y][octopus_x] = 0
  flashed_set.add(octopus)

  ADJACENT_CORDS.each do |(x, y)|
    adjacent_octopus_x = octopus_x + x
    adjacent_octopus_y = octopus_y + y
    adjacent_octopus = [adjacent_octopus_x, adjacent_octopus_y]

    if adjacent_octopus_x.negative? || adjacent_octopus_x > 9 || adjacent_octopus_y.negative? || adjacent_octopus_y > 9
      next
    end
    next if flashed_set.include?(adjacent_octopus)

    grid[adjacent_octopus_y][adjacent_octopus_x] += 1

    if grid[adjacent_octopus_y][adjacent_octopus_x] > 9
      grid[adjacent_octopus_y][adjacent_octopus_x] = 0
      flash_stack.unshift([adjacent_octopus_x, adjacent_octopus_y])
    end
  end
end

def print(grid)
  grid.each { |row| puts row.join }
  puts
end

steps = 100
total_flashes = 0
flash_stack = []
while steps.positive?
  flashed_set = Set.new
  increment_all(grid, flash_stack)

  until flash_stack.empty?
    octopus_to_flash = flash_stack.shift
    flash(octopus_to_flash, grid, flash_stack, flashed_set)
    total_flashes += 1
  end

  steps -= 1
end

puts "answer: #{total_flashes}"
