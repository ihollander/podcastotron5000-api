class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :podcast_id, :user_id

  # belongs_to :podcast, include_nested_associations: true, each_serializer: PodcastSearchSerializer
end
