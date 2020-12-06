input = File.read('./input.txt').split("\n\n").map do |input_line|
  input_line
    .tr("\n", '')
    .split('')
    .uniq
end

answer = input.reduce(0) do |acc, group_answers|
  acc += group_answers.size
  acc
end

puts answer
