# frozen_string_literal: true

depth_measurements = ARGF.each_line.map(&:to_i)

number_of_increases = 0
depth_measurements.each_with_index do |depth_measurement, index|
  next if index.zero?

  previous_depth_measurement = depth_measurements[index - 1]

  number_of_increases += 1 if depth_measurement > previous_depth_measurement
end

puts number_of_increases
