# frozen_string_literal: true

data_buffer = ARGF.read

MARKER_LENGTH = 14
start_index = MARKER_LENGTH - 1
end_index = data_buffer.length - 1
answer = 0

(start_index..end_index).each do |i|
  marker = data_buffer[i - (MARKER_LENGTH - 1)..i]

  if marker.chars.uniq.length == MARKER_LENGTH
    answer = i + 1
    break
  end
end

puts "answer: #{answer}"
