# frozen_string_literal: true

input = File.readlines('./input.txt', chomp: true)
  .map { |line| line.split('') }

# [x,y,z]
# [1, 0, -1].repeated_permutation(3).to_a
NEIGHBORS = [
  [1, 1, 1],
  [1, 1, 0],
  [1, 1, -1],
  [1, 0, 1],
  [1, 0, 0],
  [1, 0, -1],
  [1, -1, 1],
  [1, -1, 0],
  [1, -1, -1],
  [0, 1, 1],
  [0, 1, 0],
  [0, 1, -1],
  [0, 0, 1],
  [0, 0, -1],
  [0, -1, 1],
  [0, -1, 0],
  [0, -1, -1],
  [-1, 1, 1],
  [-1, 1, 0],
  [-1, 1, -1],
  [-1, 0, 1],
  [-1, 0, 0],
  [-1, 0, -1],
  [-1, -1, 1],
  [-1, -1, 0],
  [-1, -1, -1]
].freeze

CYCLES = 6
GRID_SIZE = 20
grid = {}

# initialize a NxNxN grid
(-GRID_SIZE..GRID_SIZE).each do |z_index|
  (-GRID_SIZE..GRID_SIZE).each do |y_index|
    (-GRID_SIZE..GRID_SIZE).each do |x_index|
      grid[[x_index, y_index, z_index]] = '.'
    end
  end
end

# initialize grid with input layer
input.each_with_index do |row, x_index|
  row.each_with_index do |state, y_index|
    grid[[x_index, y_index, 0]] = state if state == '#'
  end
end

def calculate_state(coords, grid)
  x, y, z = coords
  state = grid[coords]
  new_state = '.'
  active_neighbors = 0

  NEIGHBORS.each do |x_mod, y_mod, z_mod|
    key = [x + x_mod, y + y_mod, z + z_mod]
    active_neighbors += 1 if grid[key] == '#'
  end

  if state == '#'
    new_state = '#' if [2, 3].include?(active_neighbors)
  elsif active_neighbors == 3
    new_state = '#'
  end

  new_state
end

def run_cycles(cycles, grid)
  active_count = 0

  cycles.times do
    changed_coordinates = {}
    active_count = 0

    grid.each do |coords, state|
      new_state = calculate_state(coords, grid)
      changed_coordinates[coords] = new_state if new_state != state
      active_count += 1 if new_state == '#'
    end

    changed_coordinates.each do |coords, state|
      grid[coords] = state
    end
  end

  active_count
end

answer = run_cycles(CYCLES, grid)
puts answer
