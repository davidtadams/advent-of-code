# frozen_string_literal: true

require 'pry'
require 'ostruct'
require 'rgl/adjacency'
require 'rgl/traversal'

graph_data = File.read('./input.txt')
  .split("\n")
  .each_with_object({ 'edges' => [], 'weights' => {} }) do |rule_line, acc|
    bag_type, required_contents_line = rule_line.split(' bags contain ')

    next acc if required_contents_line['no other bags']

    required_contents_line.split(',').map do |required_content_line|
      number_of_bags = required_content_line.scan(/\d+/).first.to_i
      color = required_content_line.split[1, 2].join(' ')
      acc['edges'].push(bag_type, color)
      acc['weights'][[bag_type, color]] = number_of_bags
    end
  end

graph = RGL::DirectedAdjacencyGraph[*graph_data['edges']]

def find_answer(vertex, parent_vertex, graph, edge_weights)
  total_sum = graph.adjacent_vertices(vertex).reduce(0) do |acc, adj_vertex|
    sum = find_answer(adj_vertex, vertex, graph, edge_weights)
    acc += sum
    acc
  end

  return total_sum if parent_vertex.nil?

  path = [parent_vertex, vertex]
  weight = edge_weights[path]
  weight + (total_sum * weight)
end

answer = find_answer('shiny gold', nil, graph, graph_data['weights'])

puts answer
