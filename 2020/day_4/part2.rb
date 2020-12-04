passports = File.read('./input.txt').split("\n\n").map do |input_line|
  input_line.
    tr("\n", ' ').
    split(' ').
    reduce(Hash.new) do |passport, field|
      name, value = field.split(':')
      passport[name] = value
      passport
    end
end

def validate_birth_year(year)
  return false if year.nil?

  year.to_i >= 1920 && year.to_i <= 2002
end

def validate_issue_year(year)
  return false if year.nil?

  year.to_i >= 2010 && year.to_i <= 2020
end

def validate_exp_year(year)
  return false if year.nil?

  year.to_i >= 2020 && year.to_i <= 2030
end

def validate_height(height)
  return false if height.nil?

  is_valid = false
  number = height[0..-3].to_i
  unit = height[-2..-1]

  if unit == 'cm' && number >= 150 && number <= 193
    is_valid = true
  elsif unit == 'in' && number >= 59 && number <= 76
    is_valid = true
  end

  is_valid
end

def validate_hair_color(color)
  return false if color.nil?

  color.match?(/^#([a-f0-9]{6})/)
end

def validate_eye_color(color)
  return false if color.nil?

  ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(color)
end

def validate_passport_id(id)
  return false if id.nil?

  id.size == 9 && id.match?(/\d{9}/)
end

def validate_country_id(id)
  true
end

valid_passports = passports.count do |passport|
  birth_year_is_valid = validate_birth_year(passport["byr"])
  issue_year_is_valid = validate_issue_year(passport["iyr"])
  exp_year_is_valid = validate_exp_year(passport["eyr"])
  height_is_valid = validate_height(passport["hgt"])
  hair_color_is_valid = validate_hair_color(passport["hcl"])
  eye_color_is_valid = validate_eye_color(passport["ecl"])
  passport_id_is_valid = validate_passport_id(passport["pid"])
  country_id_is_valid = validate_country_id(passport["cid"])

  birth_year_is_valid && issue_year_is_valid && exp_year_is_valid && height_is_valid && hair_color_is_valid && eye_color_is_valid && passport_id_is_valid && country_id_is_valid
end

puts valid_passports
