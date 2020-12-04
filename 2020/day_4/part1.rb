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

valid_passports = passports.count do |passport|
  is_valid = false

  if passport.keys.size == 8
    is_valid = true
  elsif passport.keys.size == 7 && passport["cid"].nil?
    is_valid = true
  end

  is_valid
end

puts valid_passports
