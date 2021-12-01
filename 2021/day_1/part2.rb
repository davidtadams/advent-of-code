# frozen_string_literal: true

depth_measurements = ARGF.each_line.map(&:to_i)

number_of_increases = 0
depth_measurements.each_with_index do |_depth_measurement, index|
  next if index <= 2

  previous_window_sum = depth_measurements.slice(index - 3, 3).sum
  current_window_sum = depth_measurements.slice(index - 2, 3).sum

  number_of_increases += 1 if current_window_sum > previous_window_sum
end

puts number_of_increases
