# frozen_string_literal: true

passports = File.read('./input.txt').split("\n\n").map do |input_line|
  input_line
    .tr("\n", ' ')
    .split
    .each_with_object({}) do |field, passport|
      name, value = field.split(':')
      passport[name] = value
    end
end

valid_passports = passports.count do |passport|
  is_valid = passport.keys.size == 8 || (passport.keys.size == 7 && passport['cid'].nil?)

  is_valid
end

puts valid_passports
