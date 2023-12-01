# frozen_string_literal: true

require_relative './rope_end'

class Rope
  attr_reader :head, :tail

  def initialize
    @head = RopeEnd.new
    @tail = RopeEnd.new
    @length = 0
  end

  def move_head(direction)
    @head.move(direction)
    calculate_length
    pull_tail_to_head(direction)
  end

  private

  def pull_tail_to_head(direction)
    return if ends_touching?

    if @length == 2
      # head is exactly two steps, up, down, left, right
      move_tail(direction)
    elsif @length >= 2
      # head is not touching and is diagonal from tail
      move_tail_diagonal
    end
  end

  def move_tail(direction)
    @tail.move(direction)
  end

  def move_tail_diagonal
    # head is top right relative to tail
    move_tail('UR') if head_is_top_right?

    # head is bottom right relative to tail
    move_tail('DR') if head_is_bottom_right?

    # head is bottom left relative to tail
    move_tail('DL') if head_is_bottom_left?

    # head is top left relative to tail
    move_tail('UL') if head_is_top_left?
  end

  def head_is_top_right?
    @head.x > @tail.x && @head.y > @tail.y
  end

  def head_is_bottom_right?
    @head.x > @tail.x && @head.y < @tail.y
  end

  def head_is_bottom_left?
    @head.x < @tail.x && @head.y < @tail.y
  end

  def head_is_top_left?
    @head.x < @tail.x && @head.y > @tail.y
  end

  def ends_touching?
    @length >= 0 && @length < 2
  end

  def calculate_length
    @length = Math.sqrt(((@head.x - @tail.x)**2) + ((@head.y - @tail.y)**2))
  end
end
