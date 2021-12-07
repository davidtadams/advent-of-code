positions = ARGF.read.split(",").map(&:to_i)

average = (positions.sum / positions.length.to_f).floor

fuel_cost = positions.reduce(0) do |acc, position|
  difference = (position - average).abs
  acc + (1..difference).sum
end

puts "answer: #{fuel_cost.to_i}"
