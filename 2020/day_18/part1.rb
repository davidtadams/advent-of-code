# frozen_string_literal: true

OPERATORS = ["*", "+"].freeze
PARENS = ["(", ")"].freeze

expressions = File.readlines("./input.txt", chomp: true).map do |line|
  line.delete(" ").chars.map do |char|
    OPERATORS.include?(char) || PARENS.include?(char) ? char : char.to_i
  end
end

def find_paren_end_index(expression)
  left_count = 0
  right_count = 0
  right_index = 0

  expression.each_with_index do |char, index|
    left_count += 1 if char == "("
    right_count += 1 if char == ")"

    if left_count == right_count
      right_index = index
      break
    end
  end

  right_index
end

def evaluate_expression(expression)
  left_num = expression[0]
  operator = expression[1]
  right_num = expression[2]
  right_expression = expression[3..]

  if left_num == "("
    paren_end_index = find_paren_end_index(expression)
    paren_expression = expression[1..paren_end_index - 1]

    left_num = evaluate_expression(paren_expression)

    operator = expression[paren_end_index + 1]
    right_num = expression[paren_end_index + 2]
    right_expression = expression[paren_end_index + 3..]

    return evaluate_expression([left_num, operator, *expression[paren_end_index + 2..]]) if right_num == "("
  elsif right_num == "("
    paren_end_index = find_paren_end_index(expression[2..])
    paren_expression = expression[3..paren_end_index + 1]

    right_expression = expression[paren_end_index + 3..]

    right_num = evaluate_expression(paren_expression)
  end

  return left_num if operator.nil?

  result = left_num.method(operator).call(right_num)

  return result if right_expression.size.zero?

  evaluate_expression([result, *right_expression])
end
# rubocop:enable Metrics/MethodLength

answer = expressions.reduce(0) do |acc, expression|
  acc += evaluate_expression(expression)
  acc
end

puts "answer: #{answer}"
