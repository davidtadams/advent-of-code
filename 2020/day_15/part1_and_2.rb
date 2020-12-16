# frozen_string_literal: true

input = File.readlines('./input.txt', chomp: true).first.split(',').map(&:to_i)

PART_1_TURN_LIMIT = 2020
PART_2_TURN_LIMIT = 30_000_000

turn = 0
last_number_spoken = 0

numbers = input.each_with_object({}) do |number, numbers_hash|
  turn += 1
  numbers_hash[number] = { 'time1' => turn, 'time2' => nil }
  last_number_spoken = number
end

loop do
  turn += 1
  last_turn1 = numbers.dig(last_number_spoken, 'time1')
  last_turn2 = numbers.dig(last_number_spoken, 'time2')

  if last_turn2.nil?
    last_number_spoken = 0
  else
    last_number_spoken = last_turn1 - last_turn2
  end

  new_turn1 = numbers.dig(last_number_spoken, 'time1')

  if new_turn1.nil?
    numbers[last_number_spoken] = { 'time1' => turn, 'time2' => nil }
  else
    numbers[last_number_spoken]['time2'] = new_turn1
    numbers[last_number_spoken]['time1'] = turn
  end

  # break if turn >= PART_1_TURN_LIMIT
  break if turn >= PART_2_TURN_LIMIT
end

p last_number_spoken
