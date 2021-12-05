# frozen_string_literal: true

input_data = File.read("input.txt").split.map { |item| item.split(")") }

def build_orbit_map(input)
  orbit_map = {}

  input.each do |(parent, child)|
    if orbit_map.key?(parent)
      orbit_map[parent].push(child)
    else
      orbit_map[parent] = [child]
    end

    if orbit_map.key?(child)
      orbit_map[child].push(parent)
    else
      orbit_map[child] = [parent]
    end
  end

  orbit_map
end

def find_path_to_node(node, finish, orbit_map, previous = nil, path = [], path_length = 0, found_path = [])
  path[path_length] = node
  path_length += 1
  path_to_node = path[0..path_length - 1]

  return found_path.concat(path_to_node) if node == finish

  orbit_map[node].each do |option|
    find_path_to_node(option, finish, orbit_map, node, path, path_length, found_path) if option != previous
  end

  found_path
end
# rubocop:enable Metrics/ParameterLists

orbit_map = build_orbit_map(input_data)
path = find_path_to_node("SAN", "YOU", orbit_map)
puts "ANSWER: #{path.length - 3}"
