# frozen_string_literal: true

instructions = File
  .readlines("./input.txt", chomp: true)
  .map { |line| [line[0], line[1..].to_i] }

def rotate_waypoint(x_pos, y_pos, direction)
  radians = direction * (Math::PI / 180)
  rotated_x = (x_pos * Math.cos(radians)) - (y_pos * Math.sin(radians)).round
  rotated_y = (x_pos * Math.sin(radians)) + (y_pos * Math.cos(radians)).round
  [rotated_x, rotated_y]
end

waypoint_position = [10, 1]
ship_position = [0, 0]

instructions.each do |direction, distance|
  waypoint_x = waypoint_position[0]
  waypoint_y = waypoint_position[1]
  ship_x = ship_position[0]
  ship_y = ship_position[1]

  case direction
  when "N"
    waypoint_position = [waypoint_x, waypoint_y + distance]
  when "S"
    waypoint_position = [waypoint_x, waypoint_y - distance]
  when "E"
    waypoint_position = [waypoint_x + distance, waypoint_y]
  when "W"
    waypoint_position = [waypoint_x - distance, waypoint_y]
  when "L"
    waypoint_position = rotate_waypoint(waypoint_x, waypoint_y, distance)
  when "R"
    waypoint_position = rotate_waypoint(waypoint_x, waypoint_y, -distance)
  when "F"
    ship_position = [ship_x + (waypoint_x * distance), ship_y + (waypoint_y * distance)]
  end
end

answer = (ship_position[0].abs + ship_position[1].abs).to_i
p ship_position
puts answer
