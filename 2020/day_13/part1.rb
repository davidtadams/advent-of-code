# frozen_string_literal: true

input = File.readlines("./input.txt", chomp: true)

earliest_time = input[0].to_i
bus_lines = input[1].split(",").map(&:to_i).sort
bus_lines.delete(0)
timestamp = earliest_time
bus = nil

loop do
  bus_lines.each do |bus_line|
    if (timestamp % bus_line).zero?
      bus = bus_line
      break
    end
  end

  break if bus

  timestamp += 1
end

answer = bus * (timestamp - earliest_time)
puts answer
