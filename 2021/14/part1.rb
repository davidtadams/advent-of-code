template_input, pairs_input = ARGF.read.split("\n\n")
template = template_input.chars
pairs = pairs_input.split("\n").each_with_object({}) do |pair_input, pairs|
  pair, element = pair_input.split(" -> ")
  pairs[pair.chars] = element
end

steps = 10
while steps > 0
  new_template = []
  template.each_cons(2).with_index do |pair, index|
    if pairs[pair]
      new_template.push(pair[0], pairs[pair])
    else
      new_template.push(pair[0])
    end
    new_template.push(pair[1]) if template.size - 2 == index
  end
  template = new_template
  steps -= 1
end

occurences = template.each_with_object({}) { |key, acc| acc[key] = 0 }
template.each { |value| occurences[value] += 1 }
max = 0
min = 100000

occurences.each do |(key, value)|
  max = value if value > max
  min = value if value < min
end

answer = max - min
puts "answer: #{answer}"
