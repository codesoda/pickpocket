module Task
  class Base
    protected

    def self.open_url(url)
      `open #{url}`
    end

    def self.say(words)
      `say "#{words}"`
    end
  end
end
