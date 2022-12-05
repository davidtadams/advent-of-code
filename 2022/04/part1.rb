# frozen_string_literal: true

lines = ARGF.readlines(chomp: true).map do |line|
  line
    .split(',')
    .map do |range|
      a, b = range.split('-')
      Range.new(a.to_i, b.to_i)
    end
end

answer = lines.reduce(0) do |count, line|
  first_range, second_range = line

  if second_range.cover?(first_range) || first_range.cover?(second_range)
    count + 1
  else
    count
  end
end

puts "answer: #{answer}"
