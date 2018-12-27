class CreatePodcasts < ActiveRecord::Migration[5.2]
  def change
    create_table :podcasts do |t|
      t.string :name
      t.string :artistName
      t.string :artistViewUrl
      t.string :feedUrl
      t.string :trackViewUrl
      t.string :artworkUrl600
      t.string :logo
      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
