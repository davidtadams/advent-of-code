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

instructions.each do |(direction, fold_line)|
  points = if direction == 'y'
             fold_y(fold_line, points)
           else
             fold_x(fold_line, points)
           end
end

p points

# I took the list of points and graphed them on this site https://www.desmos.com/ :)
# answer was PFKLKCFP
