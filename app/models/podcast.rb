class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :podcast_genres, dependent: :destroy
  has_many :genres, through: :podcast_genres
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def self.find_or_create_from_api(term)
    # check if search term is in the database
    podcasts = Podcast.where("search_term = ?", term)
    if podcasts.length > 0
      podcasts
    else # if search term isn't in database, search iTunes
      newPodcasts = []
      response = ItunesAPI::ApiClient.search(term)
      response["results"].each do |json|
        rss_info = RssReader::PodcastParser.get_channel_info(json["feedUrl"]) # get RSS feed data...
        
        podcastHash = Podcast.map_json(term, json, rss_info)
        podcast = Podcast.create(podcastHash)
        newPodcasts << podcast
      end
      newPodcasts
    end
  end

  # maps to model for creating a podcast
  def self.map_json(search_term, json, rss_info)
    {
      search_term: search_term,
      name: rss_info[:title],
      logo: rss_info[:logo],
      description: rss_info[:description],
      link: rss_info[:link],
      artistName: json["artistName"],
      artistViewUrl: json["artistViewUrl"],
      feedUrl: json["feedUrl"],
      trackViewUrl: json["trackViewUrl"],
      artworkUrl600: json["artworkUrl600"]
    }
  end
  
end