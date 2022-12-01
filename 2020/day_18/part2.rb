# frozen_string_literal: true

OPERATORS = ['*', '+'].freeze
PARENS = ['(', ')'].freeze

expressions = File.readlines('./input.txt', chomp: true).map do |line|
  line.delete(' ').chars.map do |char|
    OPERATORS.include?(char) || PARENS.include?(char) ? char : char.to_i
  end
end

def evaluate_expression(expression)
  return if expression.size.zero?

  stack = []
  sign = '*'
  number = 0

  while expression.size.positive?
    char = expression.shift
    number = char if char.is_a?(Integer)

    number = evaluate_expression(expression) if char == '('

    next unless expression.size.zero? || char == '+' || char == '*' || char == ')'

    case sign
    when '+'
      prev_number = stack.pop
      stack.push(prev_number + number)
    when '*'
      stack.push(number)
    end

    sign = char
    number = 0

    break if sign == ')'
  end

  stack.reduce(1, :*)
end
answer = expressions.reduce(0) do |acc, expression|
  acc += evaluate_expression(expression)
  acc
end

puts "answer: #{answer}"
