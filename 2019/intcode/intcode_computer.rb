# frozen_string_literal: true

class IntcodeComputer
  attr_reader :output

  def initialize(intcodes)
    @intcodes = intcodes
    @pointer = 0
    @output = 0
    @relative_base = 0
    @terminated = false
  end

  def terminated?
    @terminated
  end

  def run(input = 0)
    loop do
      opcode, modes = instruction

      value1 = get_value(modes, 1)
      value2 = get_value(modes, 2)

      case opcode
      when 1
        set_value(modes, 3, value1 + value2)
        @pointer += 4
      when 2
        set_value(modes, 3, value1 * value2)
        @pointer += 4
      when 3
        set_value(modes, 1, input)
        @pointer += 2
      when 4
        @output = get_value(modes, 1)
        @pointer += 2
        break
      when 5
        value1.zero? ? @pointer += 3 : @pointer = value2
      when 6
        value1.zero? ? @pointer = value2 : @pointer += 3
      when 7
        set_value(modes, 3, value1 < value2 ? 1 : 0)
        @pointer += 4
      when 8
        set_value(modes, 3, value1 == value2 ? 1 : 0)
        @pointer += 4
      when 9
        @relative_base += value1
        @pointer += 2
      when 99
        @terminated = true
        break
      else
        puts "SOMETHING WENT WRONG! OPCODE: #{opcode}"
      end
    end

    @output
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def instruction
    instruction = @intcodes[@pointer]
    opcode = instruction % 100
    modes = (instruction / 100).digits

    [opcode, modes]
  end

  def get_value(modes, param_number)
    param_value = @intcodes[@pointer + param_number]
    mode = modes[param_number - 1]

    case mode
    when 0, nil
      value = @intcodes[param_value]
    when 1
      value = param_value
    when 2
      value = @intcodes[param_value + @relative_base]
    else
      puts "WRONG MODE GETTING A VALUE! MODE: #{mode}"
    end

    value.nil? ? 0 : value
  end

  def set_value(modes, param_number, value)
    param_value = @intcodes[@pointer + param_number]
    mode = modes[param_number - 1]

    case mode
    when 0, nil
      @intcodes[param_value] = value
    when 2
      @intcodes[param_value + @relative_base] = value
    else
      puts "WRONG MODE SETTING A VALUE! MODE: #{mode}"
    end
  end
end
