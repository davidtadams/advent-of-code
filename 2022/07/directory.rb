# frozen_string_literal: true

class Directory
  attr_accessor :name, :parent, :directories, :files, :size

  def initialize(name:, parent:, directories: [], files: [], size: 0)
    @name = name
    @parent = parent
    @directories = directories
    @files = files
    @size = size
  end

  def set_size
    child_directories_size = @directories.sum(&:size)
    file_size = @files.sum(&:size)
    @size = file_size + child_directories_size
  end
end
