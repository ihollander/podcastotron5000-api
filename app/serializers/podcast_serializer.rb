class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :artistName, :artworkUrl600, :feedUrl, :logo, :description, :link, :trackCount, :slug

  has_many :episodes
  has_many :genres

end