# frozen_string_literal: true

require "set"

instructions = File.read("./input.txt").split("\n").map do |input_line|
  instruction, argument_string = input_line.split
  [instruction, argument_string.to_i]
end

accumulator = 0
current_position = 0
visited = Set.new
keep_going = true

while keep_going
  operation, argument = instructions[current_position]

  break if visited.include?(current_position)

  visited.add(current_position)

  case operation
  when "acc"
    accumulator += argument
    current_position += 1
  when "jmp"
    current_position += argument
  else
    current_position += 1
  end
end

puts accumulator
