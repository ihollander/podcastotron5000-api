class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :episode, foreign_key: true
      t.integer :sort, default: 0
      t.boolean :played, default: false

      t.timestamps
    end
  end
end
