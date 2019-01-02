class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :pubDate, :audioLink, :audioType, :audioLength

  belongs_to :podcast
  has_many :playlists

  def playlists
    @object.playlists_for(@scope)
  end
end
