class CreatePodcastGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :podcast_genres do |t|
      t.belongs_to :genre, foreign_key: true
      t.belongs_to :podcast, foreign_key: true

      t.timestamps
    end
  end
end
