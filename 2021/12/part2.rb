require "pp"

def add_graph_node(graph, node_a, node_b)
  small = node_a == node_a.downcase

  if graph.key?(node_a)
    graph[node_a]["connections"].push(node_b)
  else
    graph[node_a] = {
      "value" => node_a,
      "connections" => [node_b],
      "small" => small
    }
  end
end

graph = {}
ARGF.each_line(chomp: true) do |line|
  start_node, end_node = line.split("-")
  add_graph_node(graph, start_node, end_node)
  add_graph_node(graph, end_node, start_node)
end

def get_paths(node_value, graph, visited, no_repeating_small_caves)
  return 0 if visited[node_value] > 0 && no_repeating_small_caves
  return 1 if node_value == "end"
  if graph[node_value]["small"]
    visited[node_value] += 1
    no_repeating_small_caves = true if visited[node_value] == 2
  end

  count = 0

  graph[node_value]["connections"].each do |connection|
    count += get_paths(connection, graph, visited, no_repeating_small_caves) if connection != "start"
  end

  visited[node_value] -= 1

  count
end

# pp graph
visited = {}
graph.keys.each { |key| visited[key] = 0 }
answer = get_paths("start", graph, visited, false)
puts "answer: #{answer}"
