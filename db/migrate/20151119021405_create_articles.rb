class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :summary
      t.string :url
      t.string :image
      t.integer :likes_count
      t.integer :comments_count
      t.references :user
      t.timestamps
    end
  end
end
