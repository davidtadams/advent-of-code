answer = File.read('./input.txt').split("\n\n").map do |input_line|
  answers = input_line.split("\n")
  number_of_people = answers.size
  answer_counts = Hash.new
  answers.join.split('').reduce(0) do |acc, answer|
    if answer_counts[answer]
      answer_counts[answer] += 1
    else
      answer_counts[answer] = 1
    end

    if answer_counts[answer] == number_of_people
      acc += 1
    end

    acc
  end
end.sum

puts answer
