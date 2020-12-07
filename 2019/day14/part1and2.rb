# frozen_string_literal: true

reactions_input = File.read('input.txt').split("\n")

class Chemical
  attr_accessor :name, :result, :inputs

  def initialize(name, result, inputs = [])
    @name = name
    @result = result
    @inputs = inputs
  end
end

class Reaction
  attr_accessor :name, :cost

  def initialize(name, cost)
    @name = name
    @cost = cost
  end
end

def parse_reaction(reaction)
  (inputs, output) = reaction.split(' => ')
  (output_result, output_name) = output.split

  input_nodes = inputs.split(', ').map do |input|
    (input_cost, input_name) = input.split
    Reaction.new(input_name, input_cost.to_i)
  end

  Chemical.new(output_name, output_result.to_i, input_nodes)
end

def build_nodes(reactions_input)
  reactions = {}

  reactions_input.each do |reaction|
    parent_node = parse_reaction(reaction)
    reactions[parent_node.name] = parent_node
  end

  reactions
end

# rubocop:todo Metrics/AbcSize
def calculate_costs(reaction_name, reaction_amount, reactions, total_costs = {}, wasted_costs = {})
  reaction = reactions[reaction_name]
  wasted_costs[reaction_name] ||= 0
  total_costs[reaction_name] ||= 0

  if reaction_amount < wasted_costs[reaction_name]
    wasted_costs[reaction_name] -= reaction_amount
  else
    multiplier = ((reaction_amount - wasted_costs[reaction_name]) / reaction.result.to_f).ceil

    total_costs[reaction_name] -= wasted_costs[reaction_name]
    wasted_costs[reaction_name] += multiplier * reaction.result - reaction_amount

    reaction.inputs.each do |input|
      total_costs[input.name] ||= 0

      quantity_needed = input.cost * multiplier
      total_costs[input.name] += quantity_needed

      calculate_costs(input.name, quantity_needed, reactions, total_costs, wasted_costs) if input.name != 'ORE'
    end
  end

  total_costs['ORE']
end
# rubocop:enable Metrics/AbcSize

reactions = build_nodes(reactions_input)
total_ore_cost = calculate_costs('FUEL', 1, reactions)
answer = (1..1_000_000_000_000).bsearch { |n| calculate_costs('FUEL', n, reactions) > 1_000_000_000_000 } - 1

puts "ANSWER #1: #{total_ore_cost}"
puts "ANSWER #2: #{answer}"
