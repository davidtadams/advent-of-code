# frozen_string_literal: true

require_relative './directory'
require_relative './file'

root_directory = Directory.new(name: '/', parent: nil)
working_directory = root_directory

# Go through the input and create the file tree
ARGF.readlines(chomp: true)[1..].each do |line|
  next if line.include?('$ ls')

  if line == '$ cd ..'
    working_directory = working_directory.parent
  elsif line.include?('$ cd ')
    new_directory_name = line[5..]
    new_directory = working_directory.directories.find { |directory| directory.name == new_directory_name }
    new_directory ||= Directory.new(name: new_directory_name, parent: working_directory)
    working_directory = new_directory
  elsif line.include?('dir ')
    new_directory_name = line[4..]
    new_directory = working_directory.directories.find { |directory| directory.name == new_directory_name }

    unless new_directory
      working_directory.directories.push(Directory.new(name: new_directory_name, parent: working_directory))
    end
  else # it is a file
    file_size, file_name = line.split
    new_file = working_directory.files.find { |file| file.name == file_name }
    working_directory.files.push(File.new(name: file_name, size: file_size.to_i)) unless new_file
  end
end

# Go through the file tree and compute the size of each directory and calculate the answer
def compute_all_dir_sizes(directory:, answer:)
  directory.size = directory.files.sum(&:size) if directory.directories.empty?

  directory.directories.each do |child_directory|
    compute_all_dir_sizes(directory: child_directory, answer:)
  end

  directory.set_size
  answer.push(directory.size) if directory.size <= 100_000
  answer
end

answer = compute_all_dir_sizes(directory: root_directory, answer: []).sum
puts "answer: #{answer}"
