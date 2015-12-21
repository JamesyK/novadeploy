class AddBookmarksCount < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.integer :bookmarks_count
    end
  end
end
