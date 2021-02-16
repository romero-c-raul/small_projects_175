arr = Dir.glob("*").select { |e| File.file?(e) }
