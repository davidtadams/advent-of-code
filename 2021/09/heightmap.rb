class Heightmap
  attr_reader :grid, :low_points, :basin_sizes

  def initialize(grid)
    @grid = grid
    @max_y = grid.size - 1
    @max_x = grid[0].size - 1
    @min_y = 0
    @min_x = 0
    @low_points = calculate_low_points
    @basin_sizes = calculate_basin_sizes
  end

  private

  def calculate_basin_sizes
    @low_points.map { |(x, y)| basin_size(x, y) }
  end

  def calculate_low_points
    low_points = []

    @grid.each_with_index do |row, y_index|
      row.each_with_index do |number, x_index|
        low_points.push([x_index, y_index]) if is_low_point?(x_index, y_index)
      end
    end

    low_points
  end

  def is_up_lower?(x_index, y_index)
    return true if y_index == @min_y

    @grid[y_index][x_index] < @grid[y_index - 1][x_index]
  end

  def is_down_lower?(x_index, y_index)
    return true if y_index == @max_y

    @grid[y_index][x_index] < @grid[y_index + 1][x_index]
  end

  def is_left_lower?(x_index, y_index)
    return true if x_index == @min_x

    @grid[y_index][x_index] < @grid[y_index][x_index - 1]
  end

  def is_right_lower?(x_index, y_index)
    return true if x_index == @max_x

    @grid[y_index][x_index] < @grid[y_index][x_index + 1]
  end

  def is_low_point?(x_index, y_index)
    is_up_lower?(x_index, y_index) &&
      is_down_lower?(x_index, y_index) &&
      is_left_lower?(x_index, y_index) &&
      is_right_lower?(x_index, y_index)
  end

  def basin_size(x, y, visited = {})
    return 0 if y < @min_y || y > @max_y || x < @min_x || x > @max_x || visited[[x, y]] || @grid[y][x] == 9

    visited[[x, y]] = true

    basin_size(x, y - 1, visited)
    basin_size(x, y + 1, visited)
    basin_size(x - 1, y, visited)
    basin_size(x + 1, y, visited)

    visited.size
  end
end
