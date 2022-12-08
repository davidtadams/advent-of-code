# frozen_string_literal: true

class File
  attr_accessor :name, :size

  def initialize(name:, size: 0)
    @name = name
    @size = size
  end
end
