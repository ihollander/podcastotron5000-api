class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :podcasts, through: :subscriptions
  

  has_many :playlists
  has_many :episodes, through: :playlists
end
