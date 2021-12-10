require_relative "./heightmap"

grid = []
ARGF.each_line(chomp: true) { |line| grid.push(line.chars.map(&:to_i)) }
heightmap = Heightmap.new(grid)
low_points = heightmap.low_points
answer = low_points.reduce(0) do |acc, low_point|
  acc + heightmap.grid[low_point[1]][low_point[0]] + 1
end

puts "answer: #{answer}"
