# frozen_string_literal: true

require 'rgl/adjacency'
require 'rgl/dot'
require 'rgl/path'

graph_edges = File.read('./input.txt').split("\n").each_with_object([]) do |rule_line, acc|
  bag_type, required_contents_line = rule_line.split(' bags contain ')

  next acc if required_contents_line['no other bags']

  required_contents_line.split(',').map do |required_content_line|
    color = required_content_line.split[1, 2].join(' ')
    acc.push(bag_type, color)
  end
end

graph = RGL::DirectedAdjacencyGraph[*graph_edges]

answer = graph.vertices.count { |vertex| graph.path?(vertex, 'shiny gold') } - 1
graph.write_to_graphic_file('jpg')

puts answer
