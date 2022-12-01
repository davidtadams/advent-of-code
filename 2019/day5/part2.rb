# frozen_string_literal: true

intcodes = File.read('input.txt').split(',').map(&:to_i)

def run_program(input, intcodes)
  pointer = 0
  instruction = intcodes[pointer]
  opcode = instruction % 100
  modes = (instruction / 100).digits

  while opcode != 99
    mode1 = modes[0] || 0
    mode2 = modes[1] || 0
    param1 = mode1.zero? ? intcodes[intcodes[pointer + 1]] : intcodes[pointer + 1]
    param2 = mode2.zero? ? intcodes[intcodes[pointer + 2]] : intcodes[pointer + 2]
    param3 = intcodes[pointer + 3]

    case opcode
    when 1
      intcodes[param3] = param1 + param2
      pointer += 4
    when 2
      intcodes[param3] = param1 * param2
      pointer += 4
    when 3
      intcodes[intcodes[pointer + 1]] = input
      pointer += 2
    when 4
      puts intcodes[intcodes[pointer + 1]]
      pointer += 2
    when 5
      if param1.zero?
        pointer += 3
      else
        pointer = param2
      end
    when 6
      if param1.zero?
        pointer = param2
      else
        pointer += 3
      end
    when 7
      intcodes[param3] = if param1 < param2
                           1
                         else
                           0
                         end

      pointer += 4
    when 8
      intcodes[param3] = if param1 == param2
                           1
                         else
                           0
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
