require 'set'

asteroid_map = File.read("input.txt").split.map { |row| row.split('') }
# asteroid_map = File.read("simple_input.txt").split.map { |row| row.split('') }

# TODO: this one could use some refactoring :<

MAX_INT = 4611686018427387903
BEST_X = 31
BEST_Y = 20
# BEST_X = 11
# BEST_Y = 13
best_point = [BEST_X, BEST_Y]
asteroid_map[BEST_Y][BEST_X] = 'X'

all_points = []

asteroid_map.each_with_index do |row, y_value|
  row.each_with_index do |point, x_value|
    if asteroid_map[y_value][x_value] == '#'
      all_points.push([x_value, y_value])
    end
  end
end

quadrants = {
  quadrant0: {},
  quadrant1: {},
  quadrant2: {},
  quadrant3: {},
}

all_points.each do |point|
  x_current = point[0]
  y_current = point[1]
  x_diff =  BEST_X.to_f - x_current.to_f
  y_diff = BEST_Y.to_f - y_current.to_f
  distance = x_diff.abs + y_diff.abs
  point_info = { distance: distance, x: x_current, y: y_current }

  if y_diff == 0
    # horizontal line
    point_info[:slope] = 0

    if x_current > BEST_X
      slope_name = 'h-right'

      if quadrants[:quadrant1].has_key?(slope_name)
        quadrants[:quadrant1][slope_name].push(point_info)
      else
        quadrants[:quadrant1][slope_name] = [point_info]
      end
    else
      slope_name = 'h-left'

      if quadrants[:quadrant3].has_key?(slope_name)
        quadrants[:quadrant3][slope_name].push(point_info)
      else
        quadrants[:quadrant3][slope_name] = [point_info]
      end
    end
  elsif x_diff == 0
    # vertical line
    point_info[:slope] = MAX_INT

    if y_current < BEST_Y
      slope_name = 'v-above'

      if quadrants[:quadrant0].has_key?(slope_name)
        quadrants[:quadrant0][slope_name].push(point_info)
      else
        quadrants[:quadrant0][slope_name] = [point_info]
      end
    else
      slope_name = 'v-below'

      if quadrants[:quadrant2].has_key?(slope_name)
        quadrants[:quadrant2][slope_name].push(point_info)
      else
        quadrants[:quadrant2][slope_name] = [point_info]
      end
    end
  else
    slope = y_diff / x_diff
    postfix = y_current < BEST_Y ? '-above' : '-below'
    slope_name = "#{slope}#{postfix}"
    point_info[:slope] = slope

    if slope < 0 && y_current < BEST_Y
      if quadrants[:quadrant0].has_key?(slope_name)
        quadrants[:quadrant0][slope_name].push(point_info)
      else
        quadrants[:quadrant0][slope_name] = [point_info]
      end
    elsif slope < 0 && y_current > BEST_Y
      if quadrants[:quadrant2].has_key?(slope_name)
        quadrants[:quadrant2][slope_name].push(point_info)
      else
        quadrants[:quadrant2][slope_name] = [point_info]
      end
    elsif slope > 0 && y_current > BEST_Y
      if quadrants[:quadrant1].has_key?(slope_name)
        quadrants[:quadrant1][slope_name].push(point_info)
      else
        quadrants[:quadrant1][slope_name] = [point_info]
      end
    elsif slope > 0 && y_current < BEST_Y
      if quadrants[:quadrant3].has_key?(slope_name)
        quadrants[:quadrant3][slope_name].push(point_info)
      else
        quadrants[:quadrant3][slope_name] = [point_info]
      end
    end
  end
end

quadrants.each do |quadrant_key, quadrant|
  quadrant.each do |slope_name, point_info|
    point_info.sort_by! { |point_info| -point_info[:distance] }
  end

  if quadrant_key == :quadrant0 || quadrant_key == :quadrant2
    # this does not actually sort hash in place
    quadrants[quadrant_key] = quadrant.sort_by { |key, value| -value.first[:slope].abs }
  else
    quadrants[quadrant_key] =quadrant.sort_by { |key, value| value.first[:slope].abs }
  end
end

vaporized_asteroids = []

while vaporized_asteroids.size < all_points.size
  quadrants.each do |quadrant_key, quadrant|
    quadrant.each do |slope_name, points|
      removed_asteroid = points.pop()

      if removed_asteroid
        vaporized_asteroids.push(removed_asteroid)
      end
    end
  end
end

# vaporized_asteroids.each { |a| print "#{a[:y]} #{a[:x]} \n" }

puts "ANSWER -> 200th Asteroid: #{vaporized_asteroids[199]}"
