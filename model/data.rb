# not thread safe
class Data
  DATA_FOLDER = "data"

  def self.read_datum(bucket, identifier)
    if !bucket || !identifier
      return nil
    end

    data = self.read_data bucket
    if data.has_key?(identifier)
      return data[identifier]
    else
      return nil
    end
  end

  # over-writes existing
  def self.write_datum(bucket, identifier, datum)
    puts File.dirname(__FILE__)
    if !bucket || !identifier
      raise Exception
    end

    data = self.read_data bucket
    data[identifier] = datum
    self.write_data(bucket, data)
  end

  def self.read_data(bucket)
    return self.read_data_from_file(self.get_filename(bucket))
  end

  def self.read_data_from_file(filename)
    data = {}
    if File.exists?(filename)
      File.open(filename, "r") do |f|
        while !f.eof?
          identifier_and_data = f.readline.split
          data[identifier_and_data[0]] = identifier_and_data[1..identifier_and_data.length-1].join
        end
      end
    end

    return data
  end

  def self.write_data(bucket, data)
    self.write_data_to_file(data, self.get_backup_filename(bucket))
    self.write_data_to_file(data, self.get_filename(bucket))
  end

  def self.write_data_to_file(data, filename)
    File.open(filename, 'w') do |f|
      for identifier in data.keys
        f.puts identifier + " " + data[identifier] + "\n"
      end
	end
  end

  def self.get_filename(bucket)
    return DATA_FOLDER + "/" + bucket
  end

  def self.get_backup_filename(bucket)
    return self.get_filename(bucket) + ".bak"
  end
end
