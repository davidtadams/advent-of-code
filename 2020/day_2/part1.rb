# frozen_string_literal: true

passwords = File.read("input.txt").split("\n").map do |password_line|
  minmax, policy_letter, password = password_line
    .tr(":", "")
    .split
  letter_min, letter_max = minmax.split("-")

  {
    letter_min: letter_min.to_i,
    letter_max: letter_max.to_i,
    policy_letter: policy_letter,
    password: password
  }
end

def validate_password(letter_min:, letter_max:, policy_letter:, password:)
  occurences = password.count(policy_letter)
  occurences >= letter_min && occurences <= letter_max
end

valid_passwords = passwords.select { |password| validate_password(**password) }

puts valid_passwords.size
