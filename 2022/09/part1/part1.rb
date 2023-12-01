# frozen_string_literal: true

require 'set'
require_relative './rope'

instructions = ARGF.readlines(chomp: true).map do |line|
  direction, number = line.split
  [direction, number.to_i]
end

rope = Rope.new
visited = Set.new

instructions.each do |instruction|
  direction, number_of_steps = instruction

  number_of_steps.times do
    rope.move_head(direction)
    visited.add(rope.tail.coordinates)
  end
end

puts "answer: #{visited.count}"
