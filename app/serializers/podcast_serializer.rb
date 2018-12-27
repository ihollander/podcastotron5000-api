class PodcastSerializer < ActiveModel::Serializer
  attributes :id, :name, :artistName, :artworkUrl600, :feedUrl, :logo, :description, :link

#     t.string "search_term"
#     t.string "name"
#     t.string "artistName"
#     t.string "artistViewUrl"
#     t.string "feedUrl"
#     t.string "trackViewUrl"
#     t.string "artworkUrl600"

end
