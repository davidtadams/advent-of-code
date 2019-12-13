require_relative '../intcode/IntcodeComputer'

intcodes = File.read("input.txt").split(",").map(&:to_i)

def get_new_location(current_direction, direction_to_go, current_x, current_y)
  new_direction = nil
  new_location = nil

  if current_direction == 'up'
    if direction_to_go == 0
      new_location = [current_x - 1, current_y]
      new_direction = 'left'
    else
      new_location = [current_x + 1, current_y]
      new_direction = 'right'
    end
  elsif current_direction == 'left'
    if direction_to_go == 0
      new_location = [current_x, current_y + 1]
      new_direction = 'down'
    else
      new_location = [current_x, current_y - 1]
      new_direction = 'up'
    end
  elsif current_direction == 'right'
    if direction_to_go == 0
      new_location = [current_x, current_y - 1]
      new_direction = 'up'
    else
      new_location = [current_x, current_y + 1]
      new_direction = 'down'
    end
  elsif current_direction == 'down'
    if direction_to_go == 0
      new_location = [current_x + 1, current_y]
      new_direction = 'right'
    else
      new_location = [current_x - 1, current_y]
      new_direction = 'left'
    end
  end

  return new_direction, new_location
end

def deploy_robot(input, intcodes)
  intcodeComputer = IntcodeComputer.new intcodes
  panels = Hash.new
  current_location = [0,0]
  current_direction = 'up'

  while !intcodeComputer.terminated?
    color_to_paint = intcodeComputer.run input
    direction_to_go = intcodeComputer.run input

    break if intcodeComputer.terminated?

    panels[current_location] = color_to_paint

    current_direction, current_location = get_new_location(current_direction, direction_to_go, current_location[0], current_location[1])

    input = panels.has_key?(current_location) ? panels[current_location] : 0
  end

  panels
end

# painted_panels = deploy_robot(0, intcodes)
painted_panels = deploy_robot(1, intcodes)

# p painted_panels.size
# p painted_panels

52.times { print 'X ' }
puts
6.times do |row_index|
  print 'X '
  50.times do |column_index|
    print painted_panels[[column_index, row_index]] == 0 ? 'X ' : '- '
  end
  puts
end
50.times { print 'X ' }
puts
