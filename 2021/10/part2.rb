scores = {")" => 1, "]" => 2, "}" => 3, ">" => 4}
open_chars = ["(", "[", "{", "<"]
open_to_close = {"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
incomplete_lines = []

ARGF.each_line(chomp: true) do |line|
  open_chars_stack = []
  corrupted_line = false
  line.chars.each do |char|
    if open_chars.include?(char)
      open_chars_stack.push(char)
    else
      last_open_char = open_chars_stack.pop
      if char != open_to_close[last_open_char]
        corrupted_line = true
        break
      end
    end
  end

  unless corrupted_line
    incomplete_line = open_chars_stack.reverse.map { |open_char| open_to_close[open_char] }
    incomplete_lines.push(incomplete_line)
  end
end

scores = incomplete_lines.map do |line|
  line.reduce(0) { |acc, char| acc * 5 + scores[char] }
end.sort
answer = scores[scores.size / 2]
puts "answer: #{answer}"
