# frozen_string_literal: true

require_relative "../intcode/intcode_computer"

intcodes = File.read("input.txt").split(",").map(&:to_i)

def get_new_location(current_direction, direction_to_go, current_x, current_y)
  new_direction = nil
  new_location = nil

  case current_direction
  when "up"
    if direction_to_go.zero?
      new_location = [current_x - 1, current_y]
      new_direction = "left"
    else
      new_location = [current_x + 1, current_y]
      new_direction = "right"
    end
  when "left"
    if direction_to_go.zero?
      new_location = [current_x, current_y + 1]
      new_direction = "down"
    else
      new_location = [current_x, current_y - 1]
      new_direction = "up"
    end
  when "right"
    if direction_to_go.zero?
      new_location = [current_x, current_y - 1]
      new_direction = "up"
    else
      new_location = [current_x, current_y + 1]
      new_direction = "down"
    end
  when "down"
    if direction_to_go.zero?
      new_location = [current_x + 1, current_y]
      new_direction = "right"
    else
      new_location = [current_x - 1, current_y]
      new_direction = "left"
    end
  end

  [new_direction, new_location]
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

def deploy_robot(input, intcodes)
  intcode_computer = IntcodeComputer.new intcodes
  panels = {}
  current_location = [0, 0]
  current_direction = "up"

  until intcode_computer.terminated?
    color_to_paint = intcode_computer.run input
    direction_to_go = intcode_computer.run input

    break if intcode_computer.terminated?

    panels[current_location] = color_to_paint

    current_direction, current_location = get_new_location(
      current_direction, direction_to_go, current_location[0], current_location[1]
    )

    input = panels.key?(current_location) ? panels[current_location] : 0
  end

  panels
end

# painted_panels = deploy_robot(0, intcodes)
painted_panels = deploy_robot(1, intcodes)

# p painted_panels.size
# p painted_panels

52.times { print "X " }
puts
6.times do |row_index|
  print "X "
  50.times do |column_index|
    print(painted_panels[[column_index, row_index]]).zero? ? "X " : "- "
  end
  puts
end
50.times { print "X " }
puts
