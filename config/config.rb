class Config

  def initialize(file_path)
    @file_path = file_path
    @config = JSON.parse(File.read(file_path))
  end

  def [](key)
    @config[key.downcase]
  end

  def []=(key, value)
    @config[key.downcase] = value
    save

    value
  end

  protected

  def save
    File.open(@file_path, 'w') do |f|
      f.write(@config.to_json)
    end
  end
end
