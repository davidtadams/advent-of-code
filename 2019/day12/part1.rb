# frozen_string_literal: true

starting_positions = File.read('input.txt').split("\n").map do |row|
  row_sections = row.split(', ')
  x = row_sections[0][3..].to_i
  y = row_sections[1][2..].to_i
  z = row_sections[2][2..-2].to_i

  [x, y, z]
end

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

def apply_velocity(moon)
  moon[:position][0] += moon[:velocity][0]
  moon[:position][1] += moon[:velocity][1]
  moon[:position][2] += moon[:velocity][2]
end

def get_total_energy(moon_data)
  moon_data.reduce(0) do |acc, (_moon_index, moon)|
    potential = moon[:position].reduce(0) { |sum, value| sum + value.abs }
    kinetic = moon[:velocity].reduce(0) { |sum, value| sum + value.abs }
    acc += potential * kinetic
    acc
  end
end

STEPS = 1000
MOONS = [0, 1, 2, 3].freeze
moon_data = starting_positions.each_with_index.with_object({}) do |(start_position, index), acc|
  acc[index] = {}
  acc[index][:position] = start_position
  acc[index][:velocity] = [0, 0, 0]
end

STEPS.times do
  MOONS.combination(2).to_a.each do |(moon1, moon2)|
    calculate_velocity(moon_data[moon1], moon_data[moon2], 0)
    calculate_velocity(moon_data[moon1], moon_data[moon2], 1)
    calculate_velocity(moon_data[moon1], moon_data[moon2], 2)
  end

  MOONS.each do |moon_index|
    apply_velocity(moon_data[moon_index])
  end
end

total_energy = get_total_energy(moon_data)
puts "ANSWER: #{total_energy}"
