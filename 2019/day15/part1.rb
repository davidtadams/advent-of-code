# frozen_string_literal: true

require "set"

require_relative "../intcode/intcode_computer"

intcodes = File.read("input.txt").split(",").map(&:to_i) # rubocop:todo Lint/UselessAssignment

intcode_computer = IntcodeComputer.new intcodes NORTH = 1
SOUTH = 2
WEST = 3
EAST = 4

WALL = 0
MOVED = 1
OXYGEN = 2

start = [0, 0]
_locations = {}

_visited = Set[start]

loop do
  _x_pos = intcode_computer.run
  _y_pos = intcode_computer.run
  _tile_id = intcode_computer.run

  # block_tiles += 1 if tile_id == 2

  break if intcode_computer.terminated?
end

# puts "ANSWER: #{block_tiles}"
