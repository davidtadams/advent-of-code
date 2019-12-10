intcodes = File.read("input.txt").split(",").map(&:to_i)

# TODO: at this point, this could use some refactoring :/
def run_program(input, intcodes)
  relative_base = 0
  pointer = 0
  instruction = intcodes[pointer]
  opcode = instruction % 100
  modes = (instruction / 100).digits

  while opcode != 99 do
    mode1 = modes[0] || 0
    mode2 = modes[1] || 0
    mode3 = modes[2] || 0
    input_param1 = intcodes[pointer + 1]
    input_param2 = intcodes[pointer + 2]
    input_param3 = intcodes[pointer + 3]

    case mode1
    when 0
      # position mode
      param1 = intcodes[input_param1]
    when 1
      # immediate mode
      param1 = input_param1
    when 2
      # relative mode
      param1 = intcodes[relative_base + input_param1]
    end

    case mode2
    when 0
      # position mode
      param2 = intcodes[input_param2]
    when 1
      # immediate mode
      param2 = input_param2
    when 2
      # relative mode
      param2 = intcodes[input_param2 + relative_base]
    end

    case mode3
    when 0
      param3 = input_param3
    when 1
      param3 = input_param3
    when 2
      param3 = input_param3 + relative_base
    end

    if param1 == nil
      param1 = 0
    end

    if param2 == nil
      param2 = 0
    end

    if param3 == nil
      param3 = 0
    end

    case opcode
    when 1
      intcodes[param3] = param1 + param2
      pointer += 4
    when 2
      intcodes[param3] = param1 * param2
      pointer += 4
    when 3
      if mode1 == 2
        intcodes[relative_base + input_param1] = input
      else
        intcodes[input_param1] = input
      end

      pointer += 2
    when 4
      puts "OUTPUT: #{param1}"

      pointer += 2
    when 5
      if param1 != 0
        pointer = param2
      else
        pointer += 3
      end
    when 6
      if param1 == 0
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
    when 9
      # adjusts the relative base by the value of its only parameter
      relative_base += param1

      pointer += 2
    else
      break
    end

    instruction = intcodes[pointer]
    opcode = instruction % 100
    modes = (instruction / 100).digits
  end
end

run_program(1, intcodes)
run_program(2, intcodes)
