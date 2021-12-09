require "set"

def map_and_remove(number, digits, digits_to_number, number_to_digits, input)
  digits_to_number[digits] = number
  number_to_digits[number] = digits
  input - [digits]
end

# 0 is the only 6 digit number that contains 7
def map_and_remove_zero(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 6 && number_to_digits[7].subset?(digits) }
  map_and_remove(0, digits, digits_to_number, number_to_digits, input)
end

# 1 is the only 2 digit number
def map_and_remove_one(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 2 }
  map_and_remove(1, digits, digits_to_number, number_to_digits, input)
end

# 2 and 5 can be done together since they are the last two
def map_and_remove_two_and_five(input, digits_to_number, number_to_digits)
  # 8 - 6 equals whatever character is in position c
  position_c = number_to_digits[8].difference(number_to_digits[6]).to_a.first

  # only 2 has position c in it
  two_digits = input.find { |digits| digits.include?(position_c) }
  new_input = map_and_remove(2, two_digits, digits_to_number, number_to_digits, input)

  # 5 is all that is left
  five_digits = new_input.first
  map_and_remove(5, five_digits, digits_to_number, number_to_digits, new_input)
end

# 3 is the only 5 digit number that contains 7
def map_and_remove_three(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 5 && number_to_digits[7].subset?(digits) }
  map_and_remove(3, digits, digits_to_number, number_to_digits, input)
end

# 4 is the only 4 digit number
def map_and_remove_four(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 4 }
  map_and_remove(4, digits, digits_to_number, number_to_digits, input)
end

# 6 is the only remaining 6 digit number by the time this is called
def map_and_remove_six(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 6 }
  map_and_remove(6, digits, digits_to_number, number_to_digits, input)
end

# 7 is the only 3 digit number
def map_and_remove_seven(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 3 }
  map_and_remove(7, digits, digits_to_number, number_to_digits, input)
end

# 8 is the only 7 digit number
def map_and_remove_eight(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 7 }
  map_and_remove(8, digits, digits_to_number, number_to_digits, input)
end

# 9 is the only 6 digit number that contains 4
def map_and_remove_nine(input, digits_to_number, number_to_digits)
  digits = input.find { |digits| digits.size == 6 && number_to_digits[4].subset?(digits) }
  map_and_remove(9, digits, digits_to_number, number_to_digits, input)
end

def map_digits_to_numbers(input)
  digits_to_number = {}
  number_to_digits = {}

  # map all of the unique numbers
  new_input = map_and_remove_one(input, digits_to_number, number_to_digits)
  new_input = map_and_remove_four(new_input, digits_to_number, number_to_digits)
  new_input = map_and_remove_seven(new_input, digits_to_number, number_to_digits)
  new_input = map_and_remove_eight(new_input, digits_to_number, number_to_digits)

  # map all of the numbers that contain a subset of a unique number
  new_input = map_and_remove_nine(new_input, digits_to_number, number_to_digits)
  new_input = map_and_remove_zero(new_input, digits_to_number, number_to_digits)
  new_input = map_and_remove_three(new_input, digits_to_number, number_to_digits)

  # map 6, by this point, it is the only 6 digit one left
  new_input = map_and_remove_six(new_input, digits_to_number, number_to_digits)

  # 2 and 5 are the only ones left
  map_and_remove_two_and_five(new_input, digits_to_number, number_to_digits)

  digits_to_number
end

answer = ARGF.read.split("\n").reduce(0) do |acc, mapping|
  input_string, output_string = mapping.split(" | ")
  input = input_string.split.map { |digits| Set[*digits.chars] }
  output = output_string.split.map { |digits| Set[*digits.chars] }
  digits_to_numbers = map_digits_to_numbers(input)
  acc + output.reduce("") { |acc, digits| acc + digits_to_numbers[digits].to_s }.to_i
end

puts "answer: #{answer}"
