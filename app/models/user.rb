class User < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :podcasts, through: :subscriptions
  

  has_many :playlists, dependent: :destroy
  has_many :episodes, through: :playlists
end
