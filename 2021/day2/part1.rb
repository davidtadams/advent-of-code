# frozen_string_literal: true

instructions = ARGF.each_line.map(&:split)

horizontal_position = 0
depth_position = 0

instructions.each do |(instruction, value)|
  case instruction
  when "forward"
    horizontal_position += value.to_i
  when "down"
    depth_position += value.to_i
  when "up"
    depth_position -= value.to_i
  end
end

answer = horizontal_position * depth_position

puts "answer: #{answer}"
