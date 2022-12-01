# frozen_string_literal: true

require 'set'

def add_graph_node(graph, node_a, node_b)
  small = node_a == node_a.downcase

  if graph.key?(node_a)
    graph[node_a]['connections'].push(node_b)
  else
    graph[node_a] = {
      'value' => node_a,
      'connections' => [node_b],
      'small' => small
    }
  end
end

graph = {}
ARGF.each_line(chomp: true) do |line|
  start_node, end_node = line.split('-')
  add_graph_node(graph, start_node, end_node)
  add_graph_node(graph, end_node, start_node)
end

def get_paths(node_value, graph, visited)
  return 0 if visited.include?(node_value)
  return 1 if node_value == 'end'

  visited.add(node_value) if graph[node_value]['small']

  count = 0

  graph[node_value]['connections'].each do |connection|
    count += get_paths(connection, graph, visited)
  end

  visited.delete(node_value)

  count
end

# pp graph
answer = get_paths('start', graph, Set.new)
puts "answer: #{answer}"
