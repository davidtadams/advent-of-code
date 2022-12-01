# frozen_string_literal: true

GRID_SIZE = 1000
GRID = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, 0) }

def draw_horizontal(x_cords, y_cord, grid)
  x1, x2 = x_cords.sort
  (x1..x2).each do |x_cord|
    grid[y_cord][x_cord] += 1
  end
end

def draw_vertical(y_cords, x_cord, grid)
  y1, y2 = y_cords.sort
  (y1..y2).each do |y_cord|
    grid[y_cord][x_cord] += 1
  end
end

ARGF.each_line(chomp: true) do |line|
  first, second = line.split(' -> ').map { |coords| coords.split(',').map(&:to_i) }
  x1, y1 = first
  x2, y2 = second

  if x1 == x2
    draw_vertical([y1, y2], x1, GRID)
  elsif y1 == y2
    draw_horizontal([x1, x2], y1, GRID)
  end
end

answer = GRID.flatten.count { |point| point >= 2 }
puts answer
