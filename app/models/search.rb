class Search < ApplicationRecord
  has_many :podcast_searches
  has_many :podcasts, through: :podcast_searches
end
