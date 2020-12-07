# frozen_string_literal: true

passwords = File.read('input.txt').split("\n").map do |password_line|
  minmax, policy_letter, password = password_line
                                    .tr(':', '')
                                    .split
  position_one, position_two = minmax.split('-')

  {
    position_one: position_one.to_i,
    position_two: position_two.to_i,
    policy_letter: policy_letter,
    password: password,
  }
end

def validate_password(position_one:, position_two:, policy_letter:, password:)
  positions = password[position_one - 1] + password[position_two - 1]
  positions.count(policy_letter) == 1
end

valid_passwords = passwords.select { |password| validate_password(**password) }

puts valid_passwords.size
