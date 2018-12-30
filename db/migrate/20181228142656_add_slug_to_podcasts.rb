class AddSlugToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :slug, :string, null: false
    add_index :podcasts, :slug, unique: true
  end
end
