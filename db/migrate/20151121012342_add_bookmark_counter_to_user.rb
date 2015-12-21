class AddBookmarkCounterToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :bookmarks_count
    end
  end
end
