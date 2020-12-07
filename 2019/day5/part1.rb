# frozen_string_literal: true

intcodes = File.read('input.txt').split(',').map(&:to_i)

# rubocop:todo Metrics/MethodLength
# rubocop:todo Metrics/AbcSize
def run_program(input, intcodes) # rubocop:todo Metrics/CyclomaticComplexity
  pointer = 0

  loop do # rubocop:todo Metrics/BlockLength
    instruction = intcodes[pointer]
    opcode = instruction % 100
    modes = (instruction / 100).digits

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
    when 99
      break
    else # rubocop:todo Lint/DuplicateBranch
      break
    end
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength

run_program(1, intcodes)
