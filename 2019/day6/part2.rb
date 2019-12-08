input_data = File.read("input.txt").split().map { |item| item.split(')') }
# input_data = File.read("simple_input_2.txt").split().map { |item| item.split(')') }

def build_orbit_map(input)
  orbit_map = Hash.new

  input.each do |(parent, child)|
    if orbit_map.has_key?(parent)
      orbit_map[parent].push(child)
    else
      orbit_map[parent] = [child]
    end

    if orbit_map.has_key?(child)
      orbit_map[child].push(parent)
    else
      orbit_map[child] = [parent]
    end
  end

  return orbit_map
end

def find_path_to_node(node, finish, orbit_map, previous = nil, path = [], pathLength = 0, found_path = [])
  path[pathLength] = node
  pathLength += 1;
  path_to_node = path[0..pathLength - 1]

  if node == finish
    return found_path.concat(path_to_node)
  end

  orbit_map[node].each do |option|
    if option != previous
      find_path_to_node(option, finish, orbit_map, node, path, pathLength, found_path)
    end
  end

  return found_path
end

orbit_map = build_orbit_map(input_data)
path = find_path_to_node("SAN", "YOU", orbit_map)
puts "ANSWER: #{path.length - 3}"
