class CreatePodcastSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :podcast_searches do |t|
      t.belongs_to :podcast, foreign_key: true
      t.belongs_to :search, foreign_key: true

      t.timestamps
    end
  end
end
