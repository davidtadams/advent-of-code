# frozen_string_literal: true

NUMBER_MAP = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
}.freeze

NUMBER_MAP_REVERSED = {
  'eno' => '1',
  'owt' => '2',
  'eerht' => '3',
  'ruof' => '4',
  'evif' => '5',
  'xis' => '6',
  'neves' => '7',
  'thgie' => '8',
  'enin' => '9',
}.freeze

def first_number_data(line)
  index_of_first_number = line.index(/\d/)

  return [nil, nil] if index_of_first_number.nil?

  first_number = line[index_of_first_number]
  [index_of_first_number, first_number]
end

def first_word_data(line, number_map)
  match_data = line.match(Regexp.new(number_map.keys.join('|')))

  return [nil, nil] if match_data.nil?

  index_of_first_word = match_data.begin(0)
  first_word_as_number = number_map[match_data[0]]
  [index_of_first_word, first_word_as_number]
end

def first_number_or_word(line, number_map)
  return line[0] if line[0].to_i.positive?

  index_of_first_number, first_number = first_number_data(line)
  index_of_first_word, first_word = first_word_data(line, number_map)

  raise 'No matches found' if index_of_first_number.nil? && index_of_first_word.nil?

  return first_number if index_of_first_word.nil?

  return first_word if index_of_first_number.nil?

  index_of_first_number < index_of_first_word ? first_number : first_word
end

def first_number(line)
  first_number_or_word(line, NUMBER_MAP)
end

def last_number(line)
  first_number_or_word(line.reverse, NUMBER_MAP_REVERSED)
end

answer = ARGF.readlines(chomp: true).reduce(0) do |sum, line|
  sum + (first_number(line) + last_number(line)).to_i
end

puts "answer: #{answer}"
