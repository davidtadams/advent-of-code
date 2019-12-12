require 'set'

asteroid_map = File.read("input.txt").split.map { |row| row.split('') }
# asteroid_map = File.read("simple_input.txt").split.map { |row| row.split('') }

all_points = []

asteroid_map.each_with_index do |row, y_value|
  row.each_with_index do |point, x_value|
    if asteroid_map[y_value][x_value] == '#'
      all_points.push({
        x: x_value,
        y: y_value,
        slopes: Set.new
      })
    end
  end
end

test_point = []

all_points.each_with_index do |current_point, current_point_index|
  all_points.each_with_index do |point, index|
    if current_point_index != index
      slope = nil
      x_current = current_point[:x]
      y_current = current_point[:y]
      x_new = point[:x]
      y_new = point[:y]
      x_diff = x_current.to_f - x_new.to_f
      y_diff = y_current.to_f - y_new.to_f

      if y_diff == 0
        # horizontal line
        slope = x_current > x_new ? '0-left' : '0-right'
      elsif x_diff == 0
        # vertical line
        slope = y_current > y_new ? 'nil-above' : 'nil-below'
      else
        postfix = y_current > y_new ? '-above' : '-below'
        slope = "#{y_diff / x_diff}#{postfix}"
      end

      current_point[:slopes].add(slope)
    end
  end
end

best_point = all_points[0]

all_points.each do |point|
  if point[:slopes].size > best_point[:slopes].size
    best_point = point
  end
end

puts "ANSWER: #{best_point[:slopes].size}"
