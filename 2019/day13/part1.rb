# frozen_string_literal: true

require_relative "../intcode/intcode_computer"

intcodes = File.read("input.txt").split(",").map(&:to_i)

intcode_computer = IntcodeComputer.new intcodes
block_tiles = 0

loop do
  _x_pos = intcode_computer.run
  _y_pos = intcode_computer.run
  tile_id = intcode_computer.run

  block_tiles += 1 if tile_id == 2

  break if intcode_computer.terminated?
end

puts "ANSWER: #{block_tiles}"
