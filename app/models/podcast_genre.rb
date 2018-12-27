class PodcastGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :podcast
end
