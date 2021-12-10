require_relative "./heightmap"

grid = []
ARGF.each_line(chomp: true) { |line| grid.push(line.chars.map(&:to_i)) }
heightmap = Heightmap.new(grid)
answer = heightmap.basin_sizes.sort.last(3).inject(:*)

puts "answer: #{answer}"
