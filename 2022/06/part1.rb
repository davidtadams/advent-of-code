# frozen_string_literal: true

data_buffer = ARGF.read

answer = 0

(3..data_buffer.length - 1).each do |i|
  marker = data_buffer[i - 3..i]

  if marker.chars.uniq.length == 4
    answer = i + 1
    break
  end
end

puts "answer: #{answer}"
