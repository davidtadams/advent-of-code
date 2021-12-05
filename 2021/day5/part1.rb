GRID_SIZE = 1000
GRID = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, 0) }

def draw_horizontal(x_cords, y_cord, grid)
  x_1, x_2 = x_cords.sort
  (x_1..x_2).each do |x_cord|
    grid[y_cord][x_cord] += 1
  end
end

def draw_vertical(y_cords, x_cord, grid)
  y_1, y_2 = y_cords.sort
  (y_1..y_2).each do |y_cord|
    grid[y_cord][x_cord] += 1
  end
end

ARGF.each_line(chomp: true) do |line|
  first, second = line.split(" -> ").map { |coords| coords.split(",").map(&:to_i) }
  x_1, y_1 = first
  x_2, y_2 = second

  if x_1 == x_2
    draw_vertical([y_1, y_2], x_1, GRID)
  elsif y_1 == y_2
    draw_horizontal([x_1, x_2], y_1, GRID)
  end
end

answer = GRID.flatten.count { |point| point >= 2 }
puts answer
