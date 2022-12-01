# frozen_string_literal: true

# This approach works for the simpler inputs, but is a brute force approach
# This takes way too long to get the answer to the full input
# I thought if I found the largest interval to iterate by, that it would be fast enough, but nope

input = File.readlines('./simple_input.txt', chomp: true)
bus_lines = input[1].split(',').map(&:to_i)
bus_lines_with_indexes = bus_lines.each_with_index.map do |bus_line, index|
  bus_line.zero? ? 0 : [bus_line, index]
end
bus_lines_with_indexes.delete(0)

def find_intervals(bus_line1_pair, other_pair)
  bus_line1, _index = bus_line1_pair
  bus_line_other, bus_line_other_index = other_pair
  current_timestamp = bus_line1
  matches = []

  while matches.size < 5
    remainder = (current_timestamp + bus_line_other_index) % bus_line_other
    matches.push(current_timestamp) if remainder.zero?
    current_timestamp += bus_line1
  end

  matches
end

def find_highest_interval(bus_line1_pair, other_pairs)
  bus_line1, _index = bus_line1_pair
  highest_interval = 0
  highest_start = 0

  other_pairs.each do |other_pair|
    bus_line_other, bus_line_other_index = other_pair
    current_timestamp = bus_line1

    loop do
      break if ((current_timestamp + bus_line_other_index) % bus_line_other).zero?

      current_timestamp += bus_line1
    end

    interval = bus_line1 * bus_line_other

    if interval > highest_interval
      highest_start = current_timestamp
      highest_interval = interval
    end
  end

  puts "highest interval: #{[highest_start, highest_interval]}"
  [highest_start, highest_interval]
end

def find_timestamp(highest_interval, bus_lines)
  current_timestamp, interval = highest_interval

  loop do
    does_it_work = bus_lines.reduce(0) do |acc, (bus_line, bus_line_index)|
      break if acc.positive?

      acc = (current_timestamp + bus_line_index) % bus_line
      acc
    end

    break if does_it_work.zero?

    current_timestamp += interval
  end

  current_timestamp
end

# intervals = find_intervals(bus_lines_with_indexes[0], bus_lines_with_indexes[2])
# puts "intervals: #{intervals}"
highest_interval = find_highest_interval(
  bus_lines_with_indexes[0],
  bus_lines_with_indexes[1..]
)
timestamp = find_timestamp(highest_interval, bus_lines_with_indexes)
p timestamp
