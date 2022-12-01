# frozen_string_literal: true

input_data = File.read('input.txt').split.map { |item| item.split(')') }

class Node
  attr_accessor :value, :children

  def initialize(value, children = [])
    @value = value
    @children = children
  end
end

def build_orbit_map(input)
  orbit_map = {}

  input.each do |(parent, child)|
    if orbit_map.key?(parent)
      orbit_map[parent].push(child)
    else
      orbit_map[parent] = [child]
    end
  end

  orbit_map
end

def build_orbit_tree(node, orbit_map, orbit_counts = [], path = [], path_length = 0)
  tree_node = Node.new(node, [])

  path[path_length] = node
  path_length += 1
  path_to_node = path[0..path_length - 1]
  orbit_counts.push(path_to_node.length - 1)

  return tree_node unless orbit_map.key?(node)

  orbit_map[node].each do |child|
    tree_node.children.push(build_orbit_tree(child, orbit_map, orbit_counts, path, path_length))
  end

  [tree_node, orbit_counts.sum]
end

orbit_map = build_orbit_map(input_data)
_orbit_tree, orbit_counts = build_orbit_tree('COM', orbit_map)
puts "Answer: #{orbit_counts}"
