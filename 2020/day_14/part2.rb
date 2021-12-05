# frozen_string_literal: true

instructions = File.readlines("./input.txt", chomp: true).map do |line|
  instruction = {}
  instruction["mask"] = line.split("mask = ")[1] if line.include?("mask")
  if line.include?("mem")
    instruction["memory_address"] = line.scan(/\[(\d+)\]/).first.first.to_i
    instruction["value"] = line.split(" = ")[1].to_i
  end
  instruction
end

def bitmask(address, mask)
  binary_address = format("%036d", address.to_s(2)).chars

  (binary_address.size - 1).downto(0) do |index|
    next if mask[index] == "0"

    binary_address[index] = mask[index]
  end

  binary_address.join
end

def get_addresses(address)
  floating_bits_count = address.count("X")
  permutations = [0, 1].repeated_permutation(floating_bits_count)

  permutations.map do |permutation|
    copy_address = address.clone

    permutation.map do |bit|
      floating_index = copy_address.index("X")
      copy_address[floating_index] = bit.to_s
    end

    copy_address.to_i(2)
  end
end

mask = nil
memory = {}

instructions.each do |instruction|
  if instruction["mask"]
    mask = instruction["mask"]
    next
  end

  memory_address = instruction["memory_address"]
  value = instruction["value"]
  masked_memory_address = bitmask(memory_address, mask)
  memory_addresses = get_addresses(masked_memory_address)
  memory_addresses.each { |address| memory[address] = value }
end

answer = memory.values.sum
puts answer
