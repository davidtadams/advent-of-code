# frozen_string_literal: true

require 'set'

asteroid_map = File.read('input.txt').split.map(&:chars)

all_points = []

asteroid_map.each_with_index do |row, y_value|
  row.each_with_index do |_point, x_value|
    next unless asteroid_map[y_value][x_value] == '#'

    all_points.push({
      x: x_value,
      y: y_value,
      slopes: Set.new,
    })
  end
end

all_points.each_with_index do |current_point, current_point_index|
  all_points.each_with_index do |point, index|
    next unless current_point_index != index

    slope = nil
    x_current = current_point[:x]
    y_current = current_point[:y]
    x_new = point[:x]
    y_new = point[:y]
    x_diff = x_current.to_f - x_new.to_f
    y_diff = y_current.to_f - y_new.to_f

    if y_diff.zero?
      # horizontal line
      x_current > x_new ? slope = '0-left' : slope = '0-right'
    elsif x_diff.zero?
      # vertical line
      y_current > y_new ? slope = 'nil-above' : slope = 'nil-below'
    else
      y_current > y_new ? postfix = '-above' : postfix = '-below'
      slope = "#{y_diff / x_diff}#{postfix}"
    end

    current_point[:slopes].add(slope)
  end
end

best_point = all_points[0]

all_points.each do |point|
  best_point = point if point[:slopes].size > best_point[:slopes].size
end

puts "ANSWER: #{best_point[:slopes].size}"
