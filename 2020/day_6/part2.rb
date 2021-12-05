# frozen_string_literal: true

final_answer = File.read('./input.txt').split("\n\n").map do |input_line|
  answers = input_line.split("\n")
  number_of_people = answers.size
  answer_counts = {}
  answers.join.chars.reduce(0) do |acc, answer|
    if answer_counts[answer]
      answer_counts[answer] += 1
    else
      answer_counts[answer] = 1
    end

    acc += 1 if answer_counts[answer] == number_of_people

    acc
  end
end.sum

puts final_answer
