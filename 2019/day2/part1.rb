input_data = File.read("input.txt").split(",").map(&:to_i)
input_data[1] = 12
input_data[2] = 2

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

puts run_opcodes(input_data)[0]
