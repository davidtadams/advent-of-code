input_data = File.read("input.txt").split("").map(&:to_i)

WIDTH = 25
HEIGHT = 6
SIZE_OF_LAYER = WIDTH * HEIGHT
NUMBER_OF_LAYERS = input_data.length / SIZE_OF_LAYER

def get_layers(data)
  layer_start = 0
  layer_end = layer_start + SIZE_OF_LAYER - 1
  layers = []

  NUMBER_OF_LAYERS.times do |time|
    layer = data[layer_start..layer_end]
    layers.push(layer)
    layer_start += SIZE_OF_LAYER
    layer_end += SIZE_OF_LAYER
  end

  return layers
end

def get_layer_number_counts(layers)
  counts = Hash.new

  layers.each_with_index do |layer, index|
    layer.each do |digit|
      if counts.has_key?(index)
        if counts[index].has_key?(digit)
          counts[index][digit] += 1
        else
          counts[index][digit] = 1
        end
      else
        counts[index] = Hash.new
        counts[index][digit] = 1
      end
    end
  end

  return counts
end

layers = get_layers(input_data)
counts = get_layer_number_counts(layers)
fewest_digit_search = 0
number, index_with_lowest =  counts.map { |key, value| value.has_key?(fewest_digit_search) ? value[fewest_digit_search] : 0 }.each_with_index.min
answer = counts[index_with_lowest][1] * counts[index_with_lowest][2]
puts "ANSWER: #{answer}"
