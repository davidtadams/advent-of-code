# frozen_string_literal: true

input = ARGF.each_line.map { |line| line.chomp.split('') }

bits_by_column = Array.new(input[0].size) { [] }
input.each do |bit_line|
  bit_line.each_with_index do |bit, index|
    bits_by_column[index].push(bit)
  end
end

gamma_rate = ''
epsilon_rate = ''

bits_by_column.each do |bit_column|
  zeros = bit_column.count('0')
  ones = bit_column.count('1')

  if zeros > ones
    gamma_rate += '1'
    epsilon_rate += '0'
  else
    gamma_rate += '0'
    epsilon_rate += '1'
  end
end

answer = gamma_rate.to_i(2) * epsilon_rate.to_i(2)
puts "answer: #{answer}"
