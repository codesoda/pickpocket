module Task
  class Lurker < Base
    TAG = 'lurker'.freeze

    def self.run(pocket)
      # find the appropriate items
      items = pocket.find_all(tag: TAG)

      # open them all in a browser
      items.each do |id, item|
        # TODO: hit the urls in code rather than opening tabs
        # http://tomtunguz.com/crawling-the-most-under-rated-hack/
        # http://www.blackhatworld.com/seo/ruby-linkedin-scraper-for-getting-more-profile-hits-and-connections.669504/
        open_url(item['resolved_url'])
      end

      say("pick pocket just lurked #{items.count} people")
      items
    end
  end
end
