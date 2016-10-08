#!/usr/bin/env ruby
require 'byebug'
require './config/environment'

TASKS = {
  'auth' => Task::Auth,
  'lurker' => Task::Lurker,
  'now' => Task::Now
}

def main(type, config)
  pocket = Pocket.new(
    config['pocket_consumer_key'],
    config['pocket_access_token']
  )
  begin
    Task.run(type, pocket)
  rescue => e
    puts e.to_s
    `say "pick pocket broke"`
  end
end

### Bootstrap the app
if ARGV.size == 0
  puts 'Argument missing, you need to specify the task, e.g.'
  puts '      $ ./pick.rb now'
  exit(1)
else
  filepath = File.expand_path(File.dirname(__FILE__))
  config = Config.new(File.join(filepath, 'config.json'))
  main ARGV[0], config
end
