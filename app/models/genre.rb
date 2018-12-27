class Genre < ApplicationRecord
  has_many :podcast_genres, dependent: :destroy
  has_many :podcasts, through: :podcast_genres
end
