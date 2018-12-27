class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :podcast
end
