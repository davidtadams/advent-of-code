# frozen_string_literal: true

def overlaps?(range1, range2)
  range1.cover?(range2.first) || range2.cover?(range1.first)
end

answer = 0
ARGF.readlines(chomp: true).each do |line|
  first_range, second_range = line
    .split(',')
    .map do |range|
      a, b = range.split('-')
      Range.new(a.to_i, b.to_i)
    end

  answer += 1 if overlaps?(first_range, second_range)
end

puts "answer: #{answer}"
