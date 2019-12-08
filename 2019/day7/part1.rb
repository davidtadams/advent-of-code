intcodes = File.read("input.txt").split(",").map(&:to_i)

# using Heap's algorithm to find all perumutations of array [0, 1, 2, 3, 4]
# https://en.wikipedia.org/wiki/Heap%27s_algorithm
# lol jk, Ruby already has this: https://apidock.com/ruby/v2_5_5/Array/permutation

def run_program(phase_setting, input_signal, intcodes)
  pointer = 0
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
      if input_count == 0
        intcodes[intcodes[pointer + 1]] = phase_setting
        input_count += 1
      else
        intcodes[intcodes[pointer + 1]] = input_signal
      end

      pointer += 2
    when 4
      return intcodes[intcodes[pointer + 1]]
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

def get_max_signal(intcodes)
  max_signal = 0
  [0, 1, 2, 3, 4].permutation.to_a.each do |permutation|
    program_output = 0

    permutation.each do |phase_setting|
      program_output = run_program(phase_setting, program_output, intcodes.clone)
    end

    if program_output > max_signal
      max_signal = program_output
    end
  end

  return max_signal
end

answer = get_max_signal(intcodes)
puts "ANSWER: #{answer}"
