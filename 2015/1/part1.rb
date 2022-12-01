# frozen_string_literal: true

input = ARGF.read
answer = input.count('(') - input.count(')')

puts "answer: #{answer}"
