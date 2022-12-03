template_input, pairs_input = ARGF.read.split("\n\n")
template = template_input.chars
pairs = pairs_input.split("\n").each_with_object({}) do |pair_input, pairs|
  pair, element = pair_input.split(" -> ")
  pairs[pair] = element
end

pair_counts = Hash.new(0)
template.each_cons(2) do |pair|
  pair_counts[pair.join] += 1
end

40.times do
  pair_counts = pair_counts.each_with_object(Hash.new(0)) do |(pair, count), acc|
    insert_element = pairs[pair]
    first = pair[0]
    second = pair[1]
    acc[first + insert_element] += count
    acc[insert_element + second] += count
  end
end

occurences = Hash.new(0)
occurences[template.first] = 1
pair_counts.each_with_object(occurences) do |(pair, count), acc|
  acc[pair[1]] += count
end

max = occurences.values.first
min = occurences.values.first
occurences.each do |(key, value)|
  max = value if value > max
  min = value if value < min
end

answer = max - min
puts "answer: #{answer}"
