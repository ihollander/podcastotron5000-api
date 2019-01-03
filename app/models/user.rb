class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: { case_sensitive: false }

  has_many :subscriptions, dependent: :destroy
  has_many :podcasts, through: :subscriptions
  
  has_many :playlists, dependent: :destroy
  has_many :episodes, through: :playlists
end
