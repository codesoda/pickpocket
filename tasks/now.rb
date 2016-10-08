module Task
  class Now < Base
    TAG = 'now'.freeze

    def self.run(pocket)
      # find the appropriate items
      items = pocket.find_all(tag: TAG)

      # open them all in a browser
      items.each do |id, item|
        open_url(item['resolved_url'])
      end

      # then remove them
      pocket.delete_all(items.map { |item| item.first }) unless items.empty?

      `say "Opened #{items.count} items tagged as, '#{TAG}'"` unless items.count == 0
      items
    end
  end
end
