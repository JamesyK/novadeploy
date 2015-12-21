class ChangeSummaryType < ActiveRecord::Migration
  def change
      change_column :articles, :summary, :text
  end
end
