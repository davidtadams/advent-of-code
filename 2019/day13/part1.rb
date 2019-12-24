require_relative '../intcode/IntcodeComputer'

intcodes = File.read("input.txt").split(",").map(&:to_i)

intcodeComputer = IntcodeComputer.new intcodes
block_tiles = 0

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
