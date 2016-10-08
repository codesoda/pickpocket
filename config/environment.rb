require './config/config'
require './pocket'
require './task'
require './tasks/base'
Dir.glob(File.expand_path('./tasks/*.rb')) { |file| require file }
