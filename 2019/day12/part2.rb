# frozen_string_literal: true

starting_positions = File.read('input.txt').split("\n").map do |row|
  row_sections = row.split(', ')
  x = row_sections[0][3..].to_i
  y = row_sections[1][2..].to_i
  z = row_sections[2][2..-2].to_i

  [x, y, z]
end

moon_positions = starting_positions.map(&:clone)

def calculate_velocity(moon1, moon2, axis)
  moon1_pos = moon1[:position][axis]
  moon2_pos = moon2[:position][axis]

  if moon1_pos > moon2_pos
    moon1[:velocity][axis] -= 1
    moon2[:velocity][axis] += 1
  elsif moon1_pos < moon2_pos
    moon1[:velocity][axis] += 1
    moon2[:velocity][axis] -= 1
  end
end

def apply_velocity(moon, axis)
  moon[:position][axis] += moon[:velocity][axis]
end

def compare_positions(original, current, axis)
  starting_values = original.map { |moon| moon[axis] }
  current_values = current.reduce([]) { |acc, (_moon_index, moon)| acc.push(moon[:position][axis]) }
  starting_values == current_values
end

MOONS = [0, 1, 2, 3].freeze
moon_data = moon_positions.each_with_index.with_object({}) do |(start_position, index), acc|
  acc[index] = {}
  acc[index][:position] = start_position
  acc[index][:velocity] = [0, 0, 0]
end

steps = 1
periods = []

[0, 1, 2].each do |axis|
  loop do
    MOONS.combination(2).to_a.each do |(moon1, moon2)|
      calculate_velocity(moon_data[moon1], moon_data[moon2], axis)
    end

    MOONS.each do |moon_index|
      apply_velocity(moon_data[moon_index], axis)
    end

    steps += 1

    break if compare_positions(starting_positions, moon_data, axis)
  end

  periods.push(steps)
  steps = 1
end

puts "ANSWER: #{periods.reduce(:lcm)}"
