# input_data = File.read("simple_input.txt").split.map { |s| s.split(',') }
input_data = File.read("input.txt").split.map { |s| s.split(',') }

class Grid
  def initialize(size, lines)
    @size = size
    @grid = Array.new(size) { Array.new(size, '.') }
    @start_x = size / 2
    @start_y = size / 2
    @grid[@start_y][@start_x] = 'o'
    @intersections = []
    draw_lines(lines)
  end

  def calc_shortest_distance
    max_int = (2**(0.size * 8 -2) -1)
    @intersections.reduce(max_int) do |memo, coordinates|
      distance = calc_manhattan_distance(coordinates[0], coordinates[1])
      distance < memo ? distance : memo
    end
  end

  def print_grid
    @grid.each do |row|
      row.each_with_index do |value, x_index|
        if x_index == @size - 1
          puts value
        else
          print "#{value} "
        end
      end
    end
  end

  private

  def calc_manhattan_distance(x, y)
    diff_x = @start_x - x
    diff_y = @start_y - y
    diff_x.abs + diff_y.abs
  end

  def draw_lines(lines)
    for line in lines
      @cur_x = @start_x
      @cur_y = @start_y

      for instruction in line
        direction = instruction[0]
        length = instruction[1..]

        if direction == 'U'
          draw_up(length.to_i)
        elsif direction == 'D'
          draw_down(length.to_i)
        elsif direction == 'L'
          draw_left(length.to_i)
        elsif direction == 'R'
          draw_right(length.to_i)
        end
      end
    end
  end

  def draw_up(length)
    (1..length).each do |i|
      @cur_y -= 1
      draw_point(i == length)
    end
  end

  def draw_down(length)
    (1..length).each do |i|
      @cur_y += 1
      draw_point(i == length)
    end
  end

  def draw_left(length)
    (1..length).each do |i|
      @cur_x -= 1
      draw_point(i == length)
    end
  end

  def draw_right(length)
    (1..length).each do |i|
      @cur_x += 1
      draw_point(i == length)
    end
  end

  def draw_point(isEnd)
    if @grid[@cur_y][@cur_x] != '.'
      @grid[@cur_y][@cur_x] = 'X'
      @intersections.append([@cur_x, @cur_y])
    elsif isEnd
      @grid[@cur_y][@cur_x] = '+'
    else
      @grid[@cur_y][@cur_x] = '|'
    end
  end
end

grid = Grid.new(40000, input_data)
# grid.print_grid
puts grid.calc_shortest_distance
