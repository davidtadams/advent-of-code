intcodes = File.read("input.txt").split(",").map(&:to_i)

def run_program(input, intcodes)
  pointer = 0
  instruction = intcodes[pointer]
  opcode = instruction % 100
  modes = (instruction / 100).digits

  while opcode != 99 do
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
    when 5
      if param_1 != 0
        pointer = param_2
      else
        pointer += 3
      end
    when 6
      if param_1 == 0
        pointer = param_2
      else
        pointer += 3
      end
    when 7
      if param_1 < param_2
        intcodes[param_3] = 1
      else
        intcodes[param_3] = 0
      end

      pointer += 4
    when 8
      if param_1 == param_2
        intcodes[param_3] = 1
      else
        intcodes[param_3] = 0
      end

      pointer += 4
    else
      break
    end

    instruction = intcodes[pointer]
    opcode = instruction % 100
    modes = (instruction / 100).digits
  end
end

run_program(5, intcodes)
