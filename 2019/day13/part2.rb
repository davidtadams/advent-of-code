# frozen_string_literal: true

require_relative '../intcode/intcode_computer'

intcodes = File.read('input.txt').split(',').map(&:to_i)

intcode_computer = IntcodeComputer.new intcodes
intcodes[0] = 2
ball = [0, 0]
paddle = [0, 0]
score = 0
joystick = 0

loop do
  x_pos = intcode_computer.run joystick
  y_pos = intcode_computer.run joystick
  output = intcode_computer.run joystick

  if x_pos == -1 && y_pos.zero?
    score = output
  elsif output == 3
    paddle = [x_pos, y_pos]
  elsif output == 4
    ball = [x_pos, y_pos]
  end

  joystick = if ball[0] > paddle[0]
               1
             elsif ball[0] < paddle[0]
               -1
             else
               0
             end

  break if intcode_computer.terminated?
end

puts "ANSWER: #{score}"
