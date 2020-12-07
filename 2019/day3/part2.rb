# frozen_string_literal: true

require 'set'

# input_data = File.read("simple_input.txt").split.map { |s| s.split(',') }
input_data = File.read('input.txt').split.map { |s| s.split(',') }

# rubocop:todo Metrics/PerceivedComplexity
# rubocop:todo Metrics/MethodLength
# rubocop:todo Metrics/AbcSize
def draw_line(line) # rubocop:todo Metrics/CyclomaticComplexity
  line_points = Set.new
  line_points_to_steps = {}
  steps = 0
  x = 0
  y = 0

  line.each do |instruction| # rubocop:todo Metrics/BlockLength
    direction = instruction[0]
    length = instruction[1..].to_i

    case direction
    when 'U'
      (1..length).each do |_i|
        line_points.add([x, y -= 1])
        steps += 1

        line_points_to_steps[[x, y]] = steps unless line_points_to_steps.key?([x, y])
      end
    when 'D'
      (1..length).each do |_i|
        line_points.add([x, y += 1])
        steps += 1

        line_points_to_steps[[x, y]] = steps unless line_points_to_steps.key?([x, y])
      end
    when 'L'
      (1..length).each do |_i|
        line_points.add([x -= 1, y])
        steps += 1

        line_points_to_steps[[x, y]] = steps unless line_points_to_steps.key?([x, y])
      end
    when 'R'
      (1..length).each do |_i|
        line_points.add([x += 1, y])
        steps += 1

        line_points_to_steps[[x, y]] = steps unless line_points_to_steps.key?([x, y])
      end
    end
  end

  [line_points, line_points_to_steps]
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity

line_1_points, line_1_steps = draw_line(input_data[0])
line_2_points, line_2_steps = draw_line(input_data[1])

puts (line_1_points & line_2_points)
  .collect { |intersection| line_1_steps[intersection] + line_2_steps[intersection] }.min
