require 'set'

# input_data = File.read("simple_input.txt").split.map { |s| s.split(',') }
input_data = File.read("input.txt").split.map { |s| s.split(',') }

def draw_line(line)
  line_points = Set.new
  line_points_to_steps = Hash.new
  steps = 0
  x = 0
  y = 0

  for instruction in line
    direction = instruction[0]
    length = instruction[1..].to_i

    if direction == 'U'
      (1..length).each do |i|
        line_points.add([x, y -= 1])
        steps += 1

        if !line_points_to_steps.has_key?([x, y])
          line_points_to_steps[[x, y]] = steps
        end
      end
    elsif direction == 'D'
      (1..length).each do |i|
        line_points.add([x, y += 1])
        steps += 1

        if !line_points_to_steps.has_key?([x, y])
          line_points_to_steps[[x, y]] = steps
        end
      end
    elsif direction == 'L'
      (1..length).each do |i|
        line_points.add([x -= 1, y])
        steps += 1

        if !line_points_to_steps.has_key?([x, y])
          line_points_to_steps[[x, y]] = steps
        end
      end
    elsif direction == 'R'
      (1..length).each do |i|
        line_points.add([x += 1, y])
        steps += 1

        if !line_points_to_steps.has_key?([x, y])
          line_points_to_steps[[x, y]] = steps
        end
      end
    end
  end

  return line_points, line_points_to_steps
end

line_1_points, line_1_steps = draw_line(input_data[0])
line_2_points, line_2_steps = draw_line(input_data[1])

puts (line_1_points & line_2_points).collect { |intersection| line_1_steps[intersection] + line_2_steps[intersection] }.min
