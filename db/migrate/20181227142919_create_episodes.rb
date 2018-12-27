class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.belongs_to :podcast, foreign_key: true
      t.string :title
      t.string :description
      t.string :pubDate
      t.string :audioLink
      t.string :audioType
      t.string :audioLength

      t.timestamps
    end
  end
end
