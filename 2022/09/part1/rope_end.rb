# frozen_string_literal: true

class RopeEnd
  attr_reader :x, :y

  def initialize
    @x = 0
    @y = 0
  end

  def coordinates
    [@x, @y]
  end

  def move(direction) # rubocop:disable Metrics/CyclomaticComplexity
    case direction
    when 'R' then move_right
    when 'L' then move_left
    when 'U' then move_up
    when 'D' then move_down
    when 'RU', 'UR' then move_up_right
    when 'RD', 'DR' then move_down_right
    when 'LD', 'DL' then move_down_left
    when 'LU', 'UL' then move_up_left
    end
  end

  private

  def move_right
    @x += 1
  end

  def move_left
    @x -= 1
  end

  def move_up
    @y += 1
  end

  def move_down
    @y -= 1
  end

  def move_up_right
    @x += 1
    @y += 1
  end

  def move_down_right
    @x += 1
    @y -= 1
  end

  def move_down_left
    @x -= 1
    @y -= 1
  end

  def move_up_left
    @x -= 1
    @y += 1
  end
end
