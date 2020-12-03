require 'set'

require_relative '../intcode/IntcodeComputer'

intcodes = File.read("input.txt").split(",").map(&:to_i)

intcodeComputer = IntcodeComputer.new intcodes

NORTH = 1
SOUTH = 2
WEST = 3
EAST = 4

WALL = 0
MOVED = 1
OXYGEN = 2

start = [0,0]
locations = {}

visited = Set[start]






loop do
  x_pos = intcodeComputer.run
  y_pos = intcodeComputer.run
  tile_id = intcodeComputer.run

  if tile_id == 2
    block_tiles += 1
  end

  break if intcodeComputer.terminated?
end

puts "ANSWER: #{block_tiles}"
