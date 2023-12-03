# frozen_string_literal: true

# an array of the below game arrays
games = ARGF.readlines(chomp: true).map do |line|
  # returns an array representation of each game and its rounds
  # example: [["3 blue", "4 red"], ["1 red", "2 green", "6 blue"], ["2 green"]]
  line.split(': ')[1].split(';').map { |a| a.split(', ').map(&:strip) }
end

possible_games = []
games.each_with_index do |game, game_index|
  impossible = false
  game.each do |round|
    round.each do |cubes|
      amount, color = cubes.split

      case color
      when 'red'
        impossible = true if amount.to_i > 12
      when 'green'
        impossible = true if amount.to_i > 13
      when 'blue'
        impossible = true if amount.to_i > 14
      else
        raise 'Color not found'
      end
    end
  end

  possible_games.push(game_index + 1) unless impossible
end

puts "answer: #{possible_games.sum}"
