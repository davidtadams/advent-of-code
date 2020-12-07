# frozen_string_literal: true

require 'set'

input_data = File.read('input.txt').split.map { |s| s.split(',') }

class Grid
  def initialize(line1, line2)
    @line1 = draw_line(line1)
    @line2 = draw_line(line2)
  end

  def calc_shortest_distance
    (@line_1 & @line_2).map { |x, y| x.abs + y.abs }.min
  end

  private

  # rubocop:todo Metrics/AbcSize
  def draw_line(line) # rubocop:todo Metrics/CyclomaticComplexity
    line_points = Set.new
    x = 0
    y = 0

    line.each do |instruction|
      direction = instruction[0]
      length = instruction[1..].to_i

      case direction
      when 'U'
        (1..length).each { line_points.add([x, y -= 1]) }
      when 'D'
        (1..length).each { line_points.add([x, y += 1]) }
      when 'L'
        (1..length).each { line_points.add([x -= 1, y]) }
      when 'R'
        (1..length).each { line_points.add([x += 1, y]) }
      end
    end

    line_points
  end
  # rubocop:enable Metrics/AbcSize
end

grid = Grid.new(input_data[0], input_data[1])
puts grid.calc_shortest_distance
