# frozen_string_literal: true

points_input, instructions_input = ARGF.read.split("\n\n")

points = points_input.split("\n").map { |point| point.split(',').map(&:to_i) }
instructions = instructions_input.split("\n")
                                 .map { |instruction| instruction.gsub('fold along ', '').split('=') }
                                 .map { |instruction| [instruction[0], instruction[1].to_i] }

def fold_y(y_line, points)
  points.map do |(x, y)|
    new_y = y
    new_y = (y - (2 * y_line)).abs if y > y_line
    [x, new_y]
  end.uniq
end

def fold_x(x_line, points)
  points.map do |(x, y)|
    new_x = x
    new_x = (x - (2 * x_line)).abs if x > x_line
    [new_x, y]
  end.uniq
end

points = if instructions[0][0] == 'y'
           fold_y(instructions[0][1], points)
         else
           fold_x(instructions[0][1], points)
         end

puts "answer: #{points.count}"
