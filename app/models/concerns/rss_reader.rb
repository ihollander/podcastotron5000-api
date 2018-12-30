require 'rss'
require 'open-uri'
require 'chronic'

module RssReader

  class PodcastParser

    def self.get_channel_info(feed_url)
      feed = self.parse(feed_url)
      episodes = self.get_episodes(feed)
      {
        link: feed.channel.link,
        description: feed.channel.description,
        episodes: episodes
      }
    end
    
    def self.get_episodes(feed)
      feed.channel.items.map do |item|
        pubDate = Chronic.parse(item.pubDate)
        {
          title: item.title,
          description: item.description,
          pubDate: item.pubDate,
          pubDateParsed: pubDate,
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