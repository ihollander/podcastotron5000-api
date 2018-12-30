require 'nokogiri'
require 'open-uri'
require 'chronic'

module RssNokogiri

  class PodcastParser

    def self.get_channel_info(feed_url, latest_episode)
      feed = self.parse(feed_url)
      episodes = self.get_episodes(feed, latest_episode)
      {
        link: feed.at_css("channel link").text,
        description: feed.at_css("channel description").text,
        episodes: episodes
      }
    end
    
    def self.get_episodes(feed, latest_episode)
      feed.css("channel item").take_while { |item|
        pubDate = DateTime.parse(item.css("pubDate").text) rescue nil
        latest_episode == nil || pubDate == nil || pubDate >= latest_episode
      }.map { |item|
        pubDate = DateTime.parse(item.css("pubDate").text) rescue nil
        link = nil
        if item.at("enclosure @url")
          link = item.at("enclosure @url").value
        elsif item.at("link")
          link = item.at("link").text
        end
        {
          title: item.css("title").text,
          description: item.css("description").text,
          pubDate: item.css("pubDate").text,
          pubDateParsed: pubDate,
          audioLink: link,
          audioType: item.at("enclosure @type") ? item.at("enclosure @type").value : nil,
          audioLength: item.at("enclosure @length") ? item.at("enclosure @length").value : nil
        }
      }
    end

    private 

    def self.parse(url)
      Nokogiri::XML(open(url))
    end
    
  end # end PodcastParser class

end # end module