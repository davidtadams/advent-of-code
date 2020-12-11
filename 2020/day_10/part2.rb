# frozen_string_literal: true

ADAPTERS = (File.read('./simple_input.txt').split("\n").map(&:to_i) + [0]).sort

def get_paths(adapter, paths)
  return 0 unless ADAPTERS.include?(adapter)

  return 1 if ADAPTERS[0] == adapter

  paths[adapter] ||= (1..3).sum { |num| get_paths(adapter - num, paths) }
end

paths = get_paths(ADAPTERS.max, {})
p paths
