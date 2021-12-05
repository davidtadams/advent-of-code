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

def bitmask(value, mask)
  value = format("%036d", value.to_s(2)).chars

  (value.size - 1).downto(0) do |index|
    next if mask[index] == "X"

    value[index] = mask[index]
  end

  value.join.to_i(2)
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

  memory[memory_address] = bitmask(value, mask)
end

answer = memory.values.sum
puts answer
