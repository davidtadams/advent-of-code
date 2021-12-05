# frozen_string_literal: true

input_data = File.read('input.txt').split

def get_total_fuel(mass)
  fuel = (mass / 3) - 2

  return 0 if fuel.negative?

  fuel + get_total_fuel(fuel)
end

def find_fuel(modules)
  modules.reduce(0) { |sum, mass| sum + get_total_fuel(mass.to_i) }
end

puts find_fuel(input_data)
