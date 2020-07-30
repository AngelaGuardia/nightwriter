class NightWriter
  original_file = ARGV[0]
  original_data = File.read(original_file)
  translated_file = ARGV[1]
  puts "Created '#{translated_file}' containing #{original_data.length} characters"
end
