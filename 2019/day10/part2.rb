# frozen_string_literal: true

require 'set'

asteroid_map = File.read('input.txt').split.map(&:chars)

# TODO: this one could use some refactoring :<

MAX_INT = 4_611_686_018_427_387_903
BEST_X = 31
BEST_Y = 20
# BEST_X = 11
# BEST_Y = 13
_best_point = [BEST_X, BEST_Y]
asteroid_map[BEST_Y][BEST_X] = 'X'

all_points = []

asteroid_map.each_with_index do |row, y_value|
  row.each_with_index do |_point, x_value|
    all_points.push([x_value, y_value]) if asteroid_map[y_value][x_value] == '#'
  end
end

quadrants = {
  quadrant0: {},
  quadrant1: {},
  quadrant2: {},
  quadrant3: {},
}

all_points.each do |point| # rubocop:todo Metrics/BlockLength
  x_current = point[0]
  y_current = point[1]
  x_diff =  BEST_X.to_f - x_current.to_f
  y_diff = BEST_Y.to_f - y_current.to_f
  distance = x_diff.abs + y_diff.abs
  point_info = { distance: distance, x: x_current, y: y_current }

  if y_diff.zero?
    # horizontal line
    point_info[:slope] = 0

    if x_current > BEST_X
      slope_name = 'h-right'

      if quadrants[:quadrant1].key?(slope_name)
        quadrants[:quadrant1][slope_name].push(point_info)
      else
        quadrants[:quadrant1][slope_name] = [point_info]
      end
    else
      slope_name = 'h-left'

      if quadrants[:quadrant3].key?(slope_name)
        quadrants[:quadrant3][slope_name].push(point_info)
      else
        quadrants[:quadrant3][slope_name] = [point_info]
      end
    end
  elsif x_diff.zero?
    # vertical line
    point_info[:slope] = MAX_INT

    if y_current < BEST_Y
      slope_name = 'v-above'

      if quadrants[:quadrant0].key?(slope_name)
        quadrants[:quadrant0][slope_name].push(point_info)
      else
        quadrants[:quadrant0][slope_name] = [point_info]
      end
    else
      slope_name = 'v-below'

      if quadrants[:quadrant2].key?(slope_name)
        quadrants[:quadrant2][slope_name].push(point_info)
      else
        quadrants[:quadrant2][slope_name] = [point_info]
      end
    end
  else
    slope = y_diff / x_diff
    y_current < BEST_Y ? postfix = '-above' : postfix = '-below'
    slope_name = "#{slope}#{postfix}"
    point_info[:slope] = slope

    if slope.negative? && y_current < BEST_Y
      if quadrants[:quadrant0].key?(slope_name)
        quadrants[:quadrant0][slope_name].push(point_info)
      else
        quadrants[:quadrant0][slope_name] = [point_info]
      end
    elsif slope.negative? && y_current > BEST_Y
      if quadrants[:quadrant2].key?(slope_name)
        quadrants[:quadrant2][slope_name].push(point_info)
      else
        quadrants[:quadrant2][slope_name] = [point_info]
      end
    elsif slope.positive? && y_current > BEST_Y
      if quadrants[:quadrant1].key?(slope_name)
        quadrants[:quadrant1][slope_name].push(point_info)
      else
        quadrants[:quadrant1][slope_name] = [point_info]
      end
    elsif slope.positive? && y_current < BEST_Y
      if quadrants[:quadrant3].key?(slope_name)
        quadrants[:quadrant3][slope_name].push(point_info)
      else
        quadrants[:quadrant3][slope_name] = [point_info]
      end
    end
  end
end

quadrants.each do |quadrant_key, quadrant|
  quadrant.each do |_slope_name, point_info|
    point_info.sort_by! { |point| -point[:distance] }
  end

  if %i[quadrant0 quadrant2].include?(quadrant_key)
    # this does not actually sort hash in place
    quadrants[quadrant_key] = quadrant.sort_by { |_key, value| -value.first[:slope].abs }
  else
    quadrants[quadrant_key] = quadrant.sort_by { |_key, value| value.first[:slope].abs }
  end
end

vaporized_asteroids = []

while vaporized_asteroids.size < all_points.size
  quadrants.each do |_quadrant_key, quadrant|
    quadrant.each do |_slope_name, points|
      removed_asteroid = points.pop

      vaporized_asteroids.push(removed_asteroid) if removed_asteroid
    end
  end
end

# vaporized_asteroids.each { |a| print "#{a[:y]} #{a[:x]} \n" }

puts "ANSWER -> 200th Asteroid: #{vaporized_asteroids[199]}"
