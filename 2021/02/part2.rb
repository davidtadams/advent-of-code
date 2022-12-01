# frozen_string_literal: true

instructions = ARGF.each_line.map(&:split)

horizontal_position = 0
depth_position = 0
aim = 0

instructions.each do |(instruction, value)|
  case instruction
  when 'forward'
    horizontal_position += value.to_i
    depth_position += aim * value.to_i
  when 'down'
    aim += value.to_i
  when 'up'
    aim -= value.to_i
  end
end

answer = horizontal_position * depth_position

puts "answer: #{answer}"
