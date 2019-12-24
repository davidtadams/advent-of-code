require_relative '../intcode/IntcodeComputer'

intcodes = File.read("input.txt").split(",").map(&:to_i)

intcodeComputer = IntcodeComputer.new intcodes
intcodes[0] = 2
ball = [0, 0]
paddle = [0, 0]
score = 0
joystick = 0

loop do
  x_pos = intcodeComputer.run joystick
  y_pos = intcodeComputer.run joystick
  output = intcodeComputer.run joystick

  if x_pos == -1 && y_pos == 0
    score = output
  elsif output == 3
    paddle = [x_pos, y_pos]
  elsif output == 4
    ball = [x_pos, y_pos]
  end

  if ball[0] > paddle[0]
    joystick = 1
  elsif ball[0] < paddle[0]
    joystick = -1
  else
    joystick = 0
  end

  break if intcodeComputer.terminated?
end

puts "ANSWER: #{score}"
