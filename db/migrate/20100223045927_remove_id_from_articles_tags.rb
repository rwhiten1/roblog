class RemoveIdFromArticlesTags < ActiveRecord::Migration
  def self.up
    remove_column :articles_tags, :id
  end

  def self.down
    add_column :articles_tags, :id, :integer
  end
end
