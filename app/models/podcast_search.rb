class PodcastSearch < ApplicationRecord
  belongs_to :podcast
  belongs_to :search
end
