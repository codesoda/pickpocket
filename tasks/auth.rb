module Task
  class Auth < Base
    def self.run(pocket, config)
      web = Thread.new {
        `python -m SimpleHTTPServer 5000 >/dev/null 2>&1`
      }

      redirect_uri = "http://localhost:5000/close.html"

      code = pocket.oauth_request(redirect_uri)

      open_url "https://getpocket.com/auth/authorize?request_token=#{code}&redirect_uri=#{redirect_uri}"
      puts "Please go to the browser and authorize 'Pick Pocket' to access your pocket account"
      sleep 3
      puts "Once you've done that press enter to continue"

      _ = STDIN.gets
      web.kill

      token = pocket.oauth_authorize(code)

      puts "Your Pick Pocket auth_token is '#{token}'"
    end
  end
end
