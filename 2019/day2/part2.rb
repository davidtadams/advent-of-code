input_data = File.read("input.txt").split(",").map(&:to_i)

def run_opcodes(opcodes)
  current_position = 0
  current_instruction = opcodes[current_position]

  while (current_instruction != 99) do
    value1 = opcodes[opcodes[current_position + 1]]
    value2 = opcodes[opcodes[current_position + 2]]
    set_position = opcodes[current_position + 3]

    if current_instruction == 1
      opcodes[set_position] = value1 + value2
    elsif current_instruction == 2
      opcodes[set_position] = value1 * value2
    end

    current_position = current_position + 4
    current_instruction = opcodes[current_position]
  end

  opcodes
end

def find_inputs(opcodes)
  desired_output = 19690720

  for noun in 0..99
    for verb in 0..99
      opcodes_copy = opcodes.clone
      opcodes_copy[1] = noun
      opcodes_copy[2] = verb
      ouput = run_opcodes(opcodes_copy)

      if ouput[0] == desired_output
        return noun, verb
      end
    end
  end
end

noun, verb = find_inputs(input_data)
puts 100 * noun + verb
