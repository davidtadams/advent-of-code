# frozen_string_literal: true

instructions = File
               .readlines('./input.txt', chomp: true)
               .map { |line| [line[0], line[1..].to_i] }

def move_forward(x_pos, y_pos, direction, distance)
  case direction
  when 0
    [x_pos, y_pos + distance]
  when 90
    [x_pos + distance, y_pos]
  when 180
    [x_pos, y_pos - distance]
  when 270
    [x_pos - distance, y_pos]
  else
    raise 'ERROR'
  end
end

def change_direction(new_direction)
  return 0 if new_direction == 360
  return new_direction - 360 if new_direction > 360
  return new_direction + 360 if new_direction.negative?

  new_direction
end

current_position = [0, 0]
current_direction = 90

instructions.each do |direction, distance|
  current_x = current_position[0]
  current_y = current_position[1]

  case direction
  when 'N'
    current_position = [current_x, current_y + distance]
  when 'S'
    current_position = [current_x, current_y - distance]
  when 'E'
    current_position = [current_x + distance, current_y]
  when 'W'
    current_position = [current_x - distance, current_y]
  when 'L'
    current_direction = change_direction(current_direction - distance)
  when 'R'
    current_direction = change_direction(current_direction + distance)
  when 'F'
    current_position = move_forward(current_x, current_y, current_direction, distance)
  end
end

answer = current_position[0].abs + current_position[1].abs
puts answer
