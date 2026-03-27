class AddRatingToBookmarks < ActiveRecord::Migration[8.1]
  def change
    add_column :bookmarks, :rating, :integer
  end
end
