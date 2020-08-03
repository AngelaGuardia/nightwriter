module FileIO
  def read
    File.read(input_filename)
  end

  def write
    File.open(output_filename, "w") { |f| f.write(translate) }
    File.read(output_filename)
  end
end
