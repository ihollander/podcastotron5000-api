class AddTrackcountToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :trackCount, :integer
  end
end
