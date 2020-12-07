# frozen_string_literal: true

require 'ostruct'

input = File.read('./input.txt').split("\n").map { |line| [line[0..6].split(''), line[7..].split('')] }

def get_upper_range(range)
  min, max = range
  min_value = ((max + min) / 2).ceil.to_f
  [min_value, max]
end

def get_lower_range(range)
  min, max = range
  max_value = ((max + min) / 2).floor.to_f
  [min, max_value]
end

def get_row(row_input)
  range = [0.to_f, 127.to_f]

  row_input.each do |row_direction|
    case row_direction
    when 'F'
      range = get_lower_range(range)
    when 'B'
      range = get_upper_range(range)
    end
  end

  range.first.to_i
end

def get_column(column_input)
  range = [0.to_f, 7.0.to_f]

  column_input.each do |row_direction|
    case row_direction
    when 'L'
      range = get_lower_range(range)
    when 'R'
      range = get_upper_range(range)
    end
  end

  range.first.to_i
end

boarding_passes = input.map do |(row_input, column_input)|
  row = get_row(row_input)
  column = get_column(column_input)
  seat_id = row * 8 + column

  OpenStruct.new({
    'row' => row,
    'column' => column,
    'seat_id' => seat_id,
  })
end

answer = boarding_passes.max { |a, b| a.seat_id <=> b.seat_id }.seat_id

puts answer
