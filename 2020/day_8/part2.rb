# frozen_string_literal: true

require "set"

instructions = File.read("./input.txt").split("\n").map do |input_line|
  instruction, argument_string = input_line.split
  [instruction, argument_string.to_i]
end

def execute_program(instructions)
  accumulator = 0
  current_position = 0
  visited = Set.new

  while current_position < instructions.size
    operation, argument = instructions[current_position]

    return nil if visited.include?(current_position)

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

  accumulator
end

current_swapped_instruction = 0
program_result = nil

loop do
  operation, argument = instructions[current_swapped_instruction]
  current_swapped_instruction += 1

  case operation
  when "jmp"
    new_operation = "nop"
  when "nop"
    new_operation = "jmp"
  else
    next
  end

  new_instructions = instructions.clone
  new_instructions[current_swapped_instruction - 1] = [new_operation, argument]

  program_result = execute_program(new_instructions)

  break unless program_result.nil?
end

p program_result
