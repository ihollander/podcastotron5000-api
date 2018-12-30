class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :pubDate, :audioLink, :audioType, :audioLength

  belongs_to :podcast
end
