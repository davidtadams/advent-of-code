input_data = File.read("input.txt").split

def find_fuel(modules)
  modules.reduce(0) { |sum, mass| sum + mass.to_i / 3 - 2 }
end

puts find_fuel(input_data)
