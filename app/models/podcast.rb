class Podcast < ApplicationRecord
  before_create :set_slug
  has_many :episodes, dependent: :destroy
  has_many :podcast_genres, dependent: :destroy
  has_many :genres, through: :podcast_genres
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :podcast_searches, dependent: :destroy
  has_many :searches, through: :podcast_searches

  def subscriptions_for(user)
    self.subscriptions.where(user: user)
  end

  def update_feed
    latest_episode = self.episodes.maximum('pubDateParsed')
    latest_episode = DateTime.parse(latest_episode.to_s) rescue nil 
    rss_info = RssNokogiri::PodcastParser.get_channel_info(self.feedUrl, latest_episode)
    rss_info[:episodes].each do |episode|
      if !Episode.find_by(title: episode[:title], pubDate: episode[:pubDate])
        self.episodes.create(episode)
      end
    end
    episode_count = self.episodes.count
    self.update(link: rss_info[:link], description: rss_info[:description], trackCount: episode_count)
  end

  def self.find_or_create_from_api(term)
    # check if search term is in the database
    podcasts = Podcast.joins(:searches).where("searches.term = ?", term)
    if podcasts.length > 0
      podcasts
    else # if search term isn't in database, search iTunes
      search = Search.find_or_create_by(term: term)
      newPodcasts = []
      response = ItunesAPI::ApiClient.search(term)
      Rails.logger.debug "iTunes response resultCount: #{response['resultCount']}"
      response["results"].each do |json|
        podcast = Podcast.find_or_create_by(name: json["trackName"], feedUrl: json["feedUrl"])
        podcastHash = Podcast.map_json(term, json)
        podcast.update(podcastHash)

        # update related tables
        genre = Genre.find_or_create_by(name: json["primaryGenreName"])
        podcast.podcast_genres.find_or_create_by(genre: genre)
        podcast.podcast_searches.create(search: search)
        newPodcasts << podcast
      end
      newPodcasts
    end
  end

  # maps to model for creating a podcast
  def self.map_json(search_term, json)
    {
      artistName: json["artistName"],
      artistViewUrl: json["artistViewUrl"],
      feedUrl: json["feedUrl"],
      trackViewUrl: json["trackViewUrl"],
      artworkUrl600: json["artworkUrl600"],
      trackCount: json["trackCount"]
    }
  end
  
  private

  def set_slug
    loop do
      self.slug = "#{self.name.truncate(50, omission: '')}-#{SecureRandom.hex(5)}".parameterize
      break unless Podcast.where(slug: slug).exists?
    end
  end

end