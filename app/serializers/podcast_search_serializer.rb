class PodcastSearchSerializer < ActiveModel::Serializer
  attributes :id, :name, :artistName, :artworkUrl600, :feedUrl, :logo, :description, :link, :trackCount, :slug
  has_many :genres
  has_many :subscriptions
  
  def subscriptions
    @object.subscriptions_for(@scope)
  end

end