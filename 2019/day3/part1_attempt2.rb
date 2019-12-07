require 'set'

# input_data = File.read("simple_input.txt").split.map { |s| s.split(',') }
input_data = File.read("input.txt").split.map { |s| s.split(',') }

class Grid
  def initialize(line_1, line_2)
    @line_1 = draw_line(line_1)
    @line_2 = draw_line(line_2)
  end

  def calc_shortest_distance
    (@line_1 & @line_2).map { |x, y| x.abs + y.abs }.min
  end

  private

  def draw_line(line)
    line_points = Set.new
    x = 0
    y = 0

    for instruction in line
      direction = instruction[0]
      length = instruction[1..].to_i

      if direction == 'U'
        (1..length).each { line_points.add([x, y -= 1]) }
      elsif direction == 'D'
        (1..length).each { line_points.add([x, y += 1]) }
      elsif direction == 'L'
        (1..length).each { line_points.add([x -= 1, y]) }
      elsif direction == 'R'
        (1..length).each { line_points.add([x += 1, y]) }
      end
    end

    line_points
  end
end

grid = Grid.new(input_data[0], input_data[1])
puts grid.calc_shortest_distance
