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

def get_final_image(layers)
  final_image = []

  SIZE_OF_LAYER.times do |layer_index|
    NUMBER_OF_LAYERS.times do |current_layer|
      layer_value = layers[current_layer][layer_index]
      final_image[layer_index] = layer_value

      if layer_value != 2
        break
      end
    end
  end

  return final_image
end

def print_image(image)
  print "\n"
  image.each_with_index do |digit, index|
    print_digit = '*'

    if digit == 0
      print_digit = ' '
    end

    if index != 0 && (index + 1) % WIDTH == 0
      print "#{print_digit}\n"
    else
      print "#{print_digit} "
    end
  end
  print "\n\n"
end

layers = get_layers(input_data)
image = get_final_image(layers)
print_image(image)
