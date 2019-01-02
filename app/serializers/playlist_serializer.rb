class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :episode_id, :sort, :played
  
  belongs_to :episode
end