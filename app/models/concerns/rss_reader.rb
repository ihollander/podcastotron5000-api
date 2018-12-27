require 'rss'
require 'open-uri'

module RssReader

  class PodcastParser

    def self.get_channel_info(feed_url)
      feed = self.parse(feed_url)
      {
        title: feed.channel.title,
        link: feed.channel.link,
        description: feed.channel.description,
        logo: feed.channel.image.url
      }
    end
    
    def self.get_episodes(feed_url)
      feed = self.parse(feed_url)

      feed.channel.items.map do |item|
        {
          title: item.title,
          description: item.description,
          pubDate: item.pubDate,
          audioLink: item.enclosure.url,
          audioType: item.enclosure.type,
          audioLength: item.enclosure.length
        }
      end
    end

    private 

    def self.parse(url)
      feed = nil
      open(url) do |rss|
        feed = RSS::Parser.parse(rss, false)
      end
      feed
    end
    
  end # end PodcastParser class

end # end module