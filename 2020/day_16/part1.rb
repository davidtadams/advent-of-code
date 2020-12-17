# frozen_string_literal: true

input = File.read('./input.txt').split("\n\n")

ticket_ranges = input[0].split("\n").map do |rule_line|
  rule_line.split(': ')[1].split(' or ').map do |range|
    lower, upper = range.split('-')
    (lower.to_i..upper.to_i)
  end
end

# your_ticket = input[1].split("\n")[1].split(',').map(&:to_i)

nearby_tickets = input[2].split("\n")[1..].map do |ticket_row|
  ticket_row.split(',').map(&:to_i)
end

invalid_numbers = []

nearby_tickets.flatten.each do |ticket_number|
  valid_number = false

  ticket_ranges.flatten.each do |range|
    if range.include?(ticket_number)
      valid_number = true
      break
    end
  end

  invalid_numbers.push(ticket_number) unless valid_number
end

puts invalid_numbers.sum
