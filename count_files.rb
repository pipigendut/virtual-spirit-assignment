require 'digest'
require 'pry'

def file_hash(file_path)
  sha256 = Digest::SHA256.new
  File.open(file_path, 'rb') do |file|
    while chunk = file.read(1024 * 1024) # Read in 1MB chunks
      sha256.update(chunk)
    end
  end
  sha256.hexdigest
end

def process_directory(directory)
  file_counts = Hash.new(0) # Hash to store hash -> count mapping
  content_map = {} # Hash to store hash -> sample content mapping

  Dir.glob("#{directory}/**/*").each do |file_path|
    next unless File.file?(file_path)

    hash = file_hash(file_path)
    file_counts[hash] += 1
    content_map[hash] ||= File.read(file_path, 100) # Store first 100 chars of content
  end

  # Find the most frequent content
  max_hash = nil
  max_count = 0
  file_counts.each do |hash, count|
    if count > max_count
      max_hash = hash
      max_count = count
    end
  end
  most_frequent_content = content_map[max_hash]

  if max_hash
    puts "#{most_frequent_content} #{max_count}"
  else
    puts "there's no same content found"
  end
end

if ARGV.empty?
  puts "Usage: ruby script.rb /path/to/directory"
else
  path = ARGV[0]

  if path && Dir.exist?(path)
    process_directory(path)
  else
    puts "Please provide a valid directory path using --path"
  end
end