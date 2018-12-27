class AddSearchTermToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :search_term, :string
  end
end
