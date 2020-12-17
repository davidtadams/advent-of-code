# frozen_string_literal: true

input = File.read('./input.txt').split("\n\n")

ticket_ranges = input[0].split("\n").map do |rule_line|
  rule_line.split(': ')[1].split(' or ').map do |range|
    lower, upper = range.split('-')
    (lower.to_i..upper.to_i)
  end
end

your_ticket = input[1].split("\n")[1].split(',').map(&:to_i)

nearby_tickets = input[2].split("\n")[1..].map do |ticket_row|
  ticket_row.split(',').map(&:to_i)
end

valid_tickets = nearby_tickets.select do |ticket|
  is_ticket_valid = true

  ticket.each do |number|
    found_ranges = 0

    ticket_ranges.each do |range1, range2|
      in_range1 = range1.include?(number)
      in_range2 = range2.include?(number)
      found_ranges += 1 if in_range1 || in_range2
    end

    is_ticket_valid = false if found_ranges.zero?
  end

  is_ticket_valid
end

valid_tickets.push(your_ticket)

position_counts = (0..ticket_ranges.size - 1).to_a.each_with_object([]) do |index, acc|
  acc[index] = Array.new(ticket_ranges.size, 0)
end

valid_tickets.each do |ticket|
  ticket.each_with_index do |number, ticket_index|
    ticket_ranges.each_with_index do |(range1, range2), range_index|
      in_range1 = range1.include?(number)
      in_range2 = range2.include?(number)
      position_counts[ticket_index][range_index] += 1 if in_range1 || in_range2
    end
  end
end

position_pairs = []
available_range_options = (0..ticket_ranges.size - 1).to_a
MAX_COUNT = valid_tickets.size

while available_range_options.size.positive?
  position_counts.each_with_index do |position_count, index|
    max_count = available_range_options.count do |option|
      position_count[option] == MAX_COUNT
    end

    next unless max_count == 1

    max_index = available_range_options.find do |option|
      position_count[option] == MAX_COUNT
    end

    position_pairs.push([max_index, index])
    available_range_options.delete(max_index)
  end
end

answer = position_pairs.sort[0..5].reduce(1) do |acc, (_pos_index, ticket_index)|
  acc * your_ticket[ticket_index]
end

puts answer
