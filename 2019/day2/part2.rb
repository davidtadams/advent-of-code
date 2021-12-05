# frozen_string_literal: true

input_data = File.read("input.txt").split(",").map(&:to_i)

def run_opcodes(opcodes)
  current_position = 0
  current_instruction = opcodes[current_position]

  while current_instruction != 99
    value1 = opcodes[opcodes[current_position + 1]]
    value2 = opcodes[opcodes[current_position + 2]]
    set_position = opcodes[current_position + 3]

    case current_instruction
    when 1
      opcodes[set_position] = value1 + value2
    when 2
      opcodes[set_position] = value1 * value2
    end

    current_position += 4
    current_instruction = opcodes[current_position]
  end

  opcodes
end

def find_inputs(opcodes)
  desired_output = 19_690_720

  (0..99).each do |noun|
    (0..99).each do |verb|
      opcodes_copy = opcodes.clone
      opcodes_copy[1] = noun
      opcodes_copy[2] = verb
      ouput = run_opcodes(opcodes_copy)

      return noun, verb if ouput[0] == desired_output
    end
  end
end

noun, verb = find_inputs(input_data)
puts (100 * noun) + verb
