intcodes = File.read("input.txt").split(",").map(&:to_i)

def run_program(phase_setting, input_signal, pointer, intcodes)
  input_count = 0
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
      if input_count == 0 && phase_setting != nil
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

  return false, false, false
end

def get_max_signal(intcodes)
  max_signal = 0
  [5, 6, 7, 8, 9].permutation.to_a.each do |permutation|
    program_output = 0

    (phase_a, phase_b, phase_c, phase_d, phase_e) = permutation
    output_a, pointer_a = 0, 0
    intcodes_a = intcodes.clone
    output_b, pointer_b = 0, 0
    intcodes_b = intcodes.clone
    output_c, pointer_c = 0, 0
    intcodes_c = intcodes.clone
    output_d, pointer_d = 0, 0
    intcodes_d = intcodes.clone
    output_e, pointer_e = 0, 0
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

    if program_output > max_signal
      max_signal = program_output
    end
  end

  return max_signal
end

answer = get_max_signal(intcodes)
puts "ANSWER: #{answer}"
