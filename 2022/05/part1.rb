# frozen_string_literal: true

# Simple stacks
# [D]
# [N] [C]
# [Z] [M] [P]
#  1   2   3

# Input stacks
#                         [R] [J] [W]
#             [R] [N]     [T] [T] [C]
# [R]         [P] [G]     [J] [P] [T]
# [Q]     [C] [M] [V]     [F] [F] [H]
# [G] [P] [M] [S] [Z]     [Z] [C] [Q]
# [P] [C] [P] [Q] [J] [J] [P] [H] [Z]
# [C] [T] [H] [T] [H] [P] [G] [L] [V]
# [F] [W] [B] [L] [P] [D] [L] [N] [G]
#  1   2   3   4   5   6   7   8   9

# simple_stacks = [
#   %w[Z N],
#   %w[M C D],
#   %w[P],
# ]

input_stacks = [
  %w[F C P G Q R],
  %w[W T C P],
  %w[B H P M C],
  %w[L T Q S M P R],
  %w[P H J Z V G N],
  %w[D P J],
  %w[L G P Z F J T R],
  %w[N L H C F P T J],
  %w[G V Z Q H T C W],
]

# [how many stacks to move, starting stack, ending stack]
instructions = ARGF.readlines(chomp: true).map { |line| line.scan(/\d+/).map(&:to_i) }

instructions.each do |(number_of_stacks_to_move, starting_stack, ending_stack)|
  number_of_stacks_to_move.times do
    crate = input_stacks[starting_stack - 1].pop
    input_stacks[ending_stack - 1].push(crate)
  end
end

answer = input_stacks.map(&:last).join
puts "answer: #{answer}"
