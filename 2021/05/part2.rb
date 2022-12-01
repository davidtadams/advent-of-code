# frozen_string_literal: true

GRID_SIZE = 1000
GRID = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, 0) }

def draw_horizontal(x_cords, y_cord)
  x1, x2 = x_cords.sort
  (x1..x2).each do |x_cord|
    GRID[y_cord][x_cord] += 1
  end
end

def draw_vertical(y_cords, x_cord)
  y1, y2 = y_cords.sort
  (y1..y2).each do |y_cord|
    GRID[y_cord][x_cord] += 1
  end
end

def draw_diagonal(x_cords, y_cords)
  x1, x2 = x_cords
  y1, y2 = y_cords
  x_points = x1 > x2 ? (x2..x1).to_a.reverse : (x1..x2).to_a
  y_points = y1 > y2 ? (y2..y1).to_a.reverse : (y1..y2).to_a

  y_points.each_with_index do |y_point, index|
    GRID[y_point][x_points[index]] += 1
  end
end

ARGF.each_line(chomp: true) do |line|
  first, second = line.split(' -> ').map { |coords| coords.split(',').map(&:to_i) }
  x1, y1 = first
  x2, y2 = second

  if x1 == x2
    draw_vertical([y1, y2], x1)
  elsif y1 == y2
    draw_horizontal([x1, x2], y1)
  else
    draw_diagonal([x1, x2], [y1, y2])
  end
end

answer = GRID.flatten.count { |point| point >= 2 }
puts answer
