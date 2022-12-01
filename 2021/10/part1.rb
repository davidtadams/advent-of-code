# frozen_string_literal: true

scores = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
open_chars = ['(', '[', '{', '<']
open_to_close = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
illegal_chars = { ')' => 0, ']' => 0, '}' => 0, '>' => 0 }

ARGF.each_line(chomp: true) do |line|
  open_chars_stack = []
  line.chars.each do |char|
    if open_chars.include?(char)
      open_chars_stack.push(char)
    else
      last_open_char = open_chars_stack.pop
      if char != open_to_close[last_open_char]
        illegal_chars[char] += 1
        break
      end
    end
  end
end

answer = illegal_chars.reduce(0) { |acc, (key, value)| acc + (scores[key] * value) }
puts "answer: #{answer}"
