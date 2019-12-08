input_data = File.read("input.txt").split().map { |item| item.split(')') }
# input_data = File.read("simple_input.txt").split().map { |item| item.split(')') }

class Node
  attr_accessor :value, :children

  def initialize(value, children = [])
    @value = value
    @children = children
  end
end

def build_orbit_map(input)
  orbit_map = Hash.new

  input.each do |(parent, child)|
    if orbit_map.has_key?(parent)
      orbit_map[parent].push(child)
    else
      orbit_map[parent] = [child]
    end
  end

  return orbit_map
end

def build_orbit_tree(node, orbit_map, orbit_counts = [], path = [], pathLength = 0)
  tree_node = Node.new(node, [])

  path[pathLength] = node
  pathLength += 1;
  path_to_node = path[0..pathLength - 1]
  orbit_counts.push(path_to_node.length - 1)

  if !orbit_map.has_key?(node)
    return tree_node
  end

  orbit_map[node].each do |child|
    tree_node.children.push(build_orbit_tree(child, orbit_map, orbit_counts, path, pathLength))
  end

  return tree_node, orbit_counts.sum
end

orbit_map = build_orbit_map(input_data)
orbit_tree, orbit_counts = build_orbit_tree("COM", orbit_map)
puts "Answer: #{orbit_counts}"
