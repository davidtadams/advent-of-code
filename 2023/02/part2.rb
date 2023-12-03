# frozen_string_literal: true

# an array of the below game arrays
games = ARGF.readlines(chomp: true).map do |line|
  # returns an array representation of each game and its rounds
  # example: [["3 blue", "4 red"], ["1 red", "2 green", "6 blue"], ["2 green"]]
  line.split(': ')[1].split(';').map { |a| a.split(', ').map(&:strip) }
end

def minimum_amount(existing_amount, new_amount)
  return new_amount if existing_amount.nil?

  [existing_amount, new_amount].max
end

powers = games.map do |game|
  minimun_cubes = { 'red' => nil, 'green' => nil, 'blue' => nil }
  game.each do |round|
    round.each do |cubes|
      amount, color = cubes.split
      case color
      when 'red'
        minimun_cubes['red'] = minimum_amount(minimun_cubes['red'], amount.to_i)
      when 'green'
        minimun_cubes['green'] = minimum_amount(minimun_cubes['green'], amount.to_i)
      when 'blue'
        minimun_cubes['blue'] = minimum_amount(minimun_cubes['blue'], amount.to_i)
      else
        raise 'Color not found'
      end
    end
  end
  minimun_cubes.values.reduce(:*)
end

puts "answer: #{powers.sum}"
