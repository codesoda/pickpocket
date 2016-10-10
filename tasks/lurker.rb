require 'mechanize'
require 'nokogiri'

module Task
  class Lurker < Base
    TAG = 'lurker'.freeze

    def self.run(pocket, config)
      # find the appropriate items
      items = pocket.find_all(tag: TAG)

      # open them all in a browser
      if items.count > 0
        agent = load_agent(
          config['linkedin_username'],
          config['linkedin_password']
        )

        items.each do |id, item|
          # TODO: hit the urls in code rather than opening tabs
          # http://tomtunguz.com/crawling-the-most-under-rated-hack/
          # http://www.blackhatworld.com/seo/ruby-linkedin-scraper-for-getting-more-profile-hits-and-connections.669504/
          agent.get(item['resolved_url'])
        end
      end

      say("pick pocket just lurked #{items.count} people")
      items
    end

    protected

    def self.load_agent(user, pass)
      agent = Mechanize.new do |a|
        a.user_agent_alias = "Mac Safari"
        a.follow_meta_refresh = true
      end

      # login to linkedin
      agent.get("https://www.linkedin.com/uas/login?goback=&trk=hb_signin")
      form = agent.page.forms.first
      #form = agent.page.form_with(action: '/uas/login-submit')
      form['session_key'] = user
      form['session_password'] = pass
      agent.submit(form)

      # TODO: login to angellist
      
      # TODO: login to other services
      
      agent
    end
  end
end
