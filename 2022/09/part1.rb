# frozen_string_literal: true

answer = ARGF.readlines(chomp: true)

puts "answer: #{answer}"

class Rope
  def initialize(x, y, a, b)
    @x_head = x
    @y_head = y
    @x_tail = a
    @y_tail = b
  end

  def distance_apart
    Math.sqrt(((@x_head - @x_tail)**2) + ((@y_head - @y_tail)**2))
  end
end

# Notes

# distances
# a = [
#   Rope.new(0, 0, 0, 1), # top
#   Rope.new(0, 0, 1, 1), # diagonal top right
#   Rope.new(0, 0, 1, 0), # right
#   Rope.new(0, 0, 1, -1), # diagonal bottom right
#   Rope.new(0, 0, 0, -1), # bottom
#   Rope.new(0, 0, -1, -1), # diagonal bottom left
#   Rope.new(0, 0, -1, 0), # left
#   Rope.new(0, 0, -1, 1), # diagonal top left
# ]
# b = [
#   Rope.new(0, 0, 1, 2), # not in same column or row and diagonal
#   Rope.new(0, 0, 2, 1), # not in same column or row and diagonal
#   Rope.new(0, 0, 2, 2), # not in same column or row and diagonal
#   Rope.new(0, 0, 0, -2), # in same column and row but not touching
# ]

# p a.map(&:distance_apart)
# [1.0, 1.4142135623730951, 1.0, 1.4142135623730951, 1.0, 1.4142135623730951, 1.0, 1.4142135623730951]
# Distances x >= 1 && < 2 are touching (greater than or equal to 1 but less than 2)

# p b.map(&:distance_apart)
# [2.23606797749979, 2.23606797749979, 2.0]
# Distances >= 2 are not touching

# Distance of exactly 2 means the head is two steps directly up, down, left, or right
# This means the tail has to move in the direction of the head
# if head is to the right move to the right and so on

# Distance if greater than 2 means that there must be a diagonal move
# if head is top right => diagonal right move
# if head is top left => diagonal left move and so on

# Distance of 0 means they are the same

# use a set to keep track of the coordinates that the tail visits
