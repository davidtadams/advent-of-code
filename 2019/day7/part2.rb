# frozen_string_literal: true

intcodes = File.read('input.txt').split(',').map(&:to_i)

# rubocop:todo Metrics/PerceivedComplexity
# rubocop:todo Metrics/MethodLength
# rubocop:todo Metrics/AbcSize
def run_program(phase_setting, input_signal, pointer, intcodes) # rubocop:todo Metrics/CyclomaticComplexity
  input_count = 0
  instruction = intcodes[pointer]
  opcode = instruction % 100
  modes = (instruction / 100).digits

  while opcode != 99
    mode1 = modes[0] || 0
    mode2 = modes[1] || 0

    mode1.zero? ? param1 = intcodes[intcodes[pointer + 1]] : param1 = intcodes[pointer + 1]
    mode2.zero? ? param2 = intcodes[intcodes[pointer + 2]] : param2 = intcodes[pointer + 2]
    param3 = intcodes[pointer + 3]

    case opcode
    when 1
      intcodes[param3] = param1 + param2
      pointer += 4
    when 2
      intcodes[param3] = param1 * param2
      pointer += 4
    when 3
      if input_count.zero? && !phase_setting.nil?
        intcodes[intcodes[pointer + 1]] = phase_setting
        input_count += 1
      else
        intcodes[intcodes[pointer + 1]] = input_signal
      end

      pointer += 2
    when 4
      output = intcodes[intcodes[pointer + 1]]
      pointer += 2

      return output, pointer, intcodes
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
      if param1 < param2
        intcodes[param3] = 1
      else
        intcodes[param3] = 0
      end

      pointer += 4
    when 8
      if param1 == param2
        intcodes[param3] = 1
      else
        intcodes[param3] = 0
      end

      pointer += 4
    else
      break
    end

    instruction = intcodes[pointer]
    opcode = instruction % 100
    modes = (instruction / 100).digits
  end

  [false, false, false]
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity

# rubocop:todo Metrics/MethodLength
def get_max_signal(intcodes) # rubocop:todo Metrics/AbcSize
  max_signal = 0
  [5, 6, 7, 8, 9].permutation.to_a.each do |permutation| # rubocop:todo Metrics/BlockLength
    program_output = 0

    (phase_a, phase_b, phase_c, phase_d, phase_e) = permutation
    output_a = 0
    pointer_a = 0
    intcodes_a = intcodes.clone
    output_b = 0
    pointer_b = 0
    intcodes_b = intcodes.clone
    output_c = 0
    pointer_c = 0
    intcodes_c = intcodes.clone
    output_d = 0
    pointer_d = 0
    intcodes_d = intcodes.clone
    output_e = 0
    pointer_e = 0
    intcodes_e = intcodes.clone

    output_a, pointer_a, intcodes_a = run_program(phase_a, 0, pointer_a, intcodes_a)
    output_b, pointer_b, intcodes_b = run_program(phase_b, output_a, pointer_b, intcodes_b)
    output_c, pointer_c, intcodes_c = run_program(phase_c, output_b, pointer_c, intcodes_c)
    output_d, pointer_d, intcodes_d = run_program(phase_d, output_c, pointer_d, intcodes_d)
    output_e, pointer_e, intcodes_e = run_program(phase_e, output_d, pointer_e, intcodes_e)

    loop do
      output_a, pointer_a, intcodes_a = run_program(nil, output_e, pointer_a, intcodes_a)

      if output_a == false
        program_output = output_e
        break
      end

      output_b, pointer_b, intcodes_b = run_program(nil, output_a, pointer_b, intcodes_b)
      output_c, pointer_c, intcodes_c = run_program(nil, output_b, pointer_c, intcodes_c)
      output_d, pointer_d, intcodes_d = run_program(nil, output_c, pointer_d, intcodes_d)
      output_e, pointer_e, intcodes_e = run_program(nil, output_d, pointer_e, intcodes_e)
    end

    max_signal = program_output if program_output > max_signal
  end

  max_signal
end
# rubocop:enable Metrics/MethodLength

answer = get_max_signal(intcodes)
puts "ANSWER: #{answer}"
