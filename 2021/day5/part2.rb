GRID_SIZE = 1000
GRID = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, 0) }

def draw_horizontal(x_cords, y_cord)
  x_1, x_2 = x_cords.sort
  (x_1..x_2).each do |x_cord|
    GRID[y_cord][x_cord] += 1
  end
end

def draw_vertical(y_cords, x_cord)
  y_1, y_2 = y_cords.sort
  (y_1..y_2).each do |y_cord|
    GRID[y_cord][x_cord] += 1
  end
end

def draw_diagonal(x_cords, y_cords)
  x_1, x_2 = x_cords
  y_1, y_2 = y_cords
  x_points = x_1 > x_2 ? (x_2..x_1).to_a.reverse : (x_1..x_2).to_a
  y_points = y_1 > y_2 ? (y_2..y_1).to_a.reverse : (y_1..y_2).to_a

  y_points.each_with_index do |y_point, index|
    GRID[y_point][x_points[index]] += 1
  end
end

ARGF.each_line(chomp: true) do |line|
  first, second = line.split(" -> ").map { |coords| coords.split(",").map(&:to_i) }
  x_1, y_1 = first
  x_2, y_2 = second

  if x_1 == x_2
    draw_vertical([y_1, y_2], x_1)
  elsif y_1 == y_2
    draw_horizontal([x_1, x_2], y_1)
  else
    draw_diagonal([x_1, x_2], [y_1, y_2])
  end
end

answer = GRID.flatten.count { |point| point >= 2 }
puts answer
