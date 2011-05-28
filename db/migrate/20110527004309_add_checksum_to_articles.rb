class AddChecksumToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :checksum, :string
    add_column :articles, :body_raw, :string
  end

  def self.down
    remove_column :articles, :checksum
    remove_column :articles, :body_raw
  end
end
