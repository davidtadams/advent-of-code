# frozen_string_literal: true

require "pry-byebug"

# I had to look this one up to find an efficient solution
# used the Chinese Remainder Theorem
# https://en.wikipedia.org/wiki/Chinese_remainder_theorem
# https://www.geeksforgeeks.org/chinese-remainder-theorem-set-2-implementation/
# https://www.geeksforgeeks.org/multiplicative-inverse-under-modulo-m/

input = File.readlines("./input.txt", chomp: true)
bus_lines = input[1].split(",").map(&:to_i)

def modulo_inverse(num_a, num_m)
  return 0 if num_m == 1

  m0 = num_m
  x0 = 0
  x1 = 1

  while num_a > 1
    quotient = num_a / num_m
    temp = num_m
    num_m = num_a % num_m
    num_a = temp
    temp = x0
    x0 = x1 - (quotient * x0)
    x1 = temp
  end

  x1 += m0 if x1.negative?
  x1
end

def find_min_timestamp(numbers, remainders)
  product = numbers.reduce(1, :*)
  product_numbers = numbers.map { |number| product / number }
  min_timestamp = 0

  numbers.each_with_index do |number, index|
    remainder = remainders[index]
    product_number = product_numbers[index]

    min_timestamp += remainder * modulo_inverse(product_number, number) * product_number
  end

  min_timestamp % product
end

numbers = []
remainders = []
bus_lines.each_with_index do |bus_line, index|
  if index.zero?
    numbers.push(bus_line)
    remainders.push(index)
  elsif bus_line != 0
    numbers.push(bus_line)
    remainders.push(bus_line - index)
  end
end

puts find_min_timestamp(numbers, remainders)
