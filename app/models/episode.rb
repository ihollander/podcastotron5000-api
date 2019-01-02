class Episode < ApplicationRecord
  belongs_to :podcast
  has_many :subscriptions, through: :podcast
  has_many :playlists

  scope :by_user, -> (user) { joins(:podcast).joins(:subscriptions).where(subscriptions: { user: user }) }
  scope :recent, -> () { order(pubDateParsed: :desc) }

  def playlists_for(user)
    self.playlists.where(user: user)
  end
end
