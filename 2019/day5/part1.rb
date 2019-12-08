intcodes = File.read("input.txt").split(",").map(&:to_i)

def run_program(input, intcodes)
  pointer = 0

  loop do
    instruction = intcodes[pointer]
    opcode = instruction % 100
    modes = (instruction / 100).digits

    mode_1 = modes[0] || 0
    mode_2 = modes[1] || 0
    param_1 = mode_1 == 0 ? intcodes[intcodes[pointer + 1]] : intcodes[pointer + 1]
    param_2 = mode_2 == 0 ? intcodes[intcodes[pointer + 2]] : intcodes[pointer + 2]
    param_3 = intcodes[pointer + 3]

    case opcode
    when 1
      intcodes[param_3] = param_1 + param_2
      pointer += 4
    when 2
      intcodes[param_3] = param_1 * param_2
      pointer += 4
    when 3
      intcodes[intcodes[pointer + 1]] = input
      pointer += 2
    when 4
      puts intcodes[intcodes[pointer + 1]]
      pointer += 2
    when 99
      break
    else
      break
    end
  end
end

run_program(1, intcodes)
