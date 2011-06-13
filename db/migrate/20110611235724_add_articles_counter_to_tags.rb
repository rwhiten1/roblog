class AddArticlesCounterToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :articles_count, :integer, :default => 0
    Tag.reset_column_information
    Tag.find(:all).each do |t|
      Tag.update_counters t.id, :articles_count => t.articles.count
    end
  end

  def self.down
    remove_column :tags, :articles_count
  end
end
